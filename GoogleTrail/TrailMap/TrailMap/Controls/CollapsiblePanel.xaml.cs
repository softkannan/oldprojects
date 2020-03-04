using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Windows.Controls.Primitives;

namespace TrailMap.Controls
{
    [TemplatePart(Name = CollapsiblePanel.ExpandCollapseButton, Type = typeof(FrameworkElement))]
    [TemplatePart(Name = CollapsiblePanel.ContentContainer, Type = typeof(Panel))]
    [TemplatePart(Name = CollapsiblePanel.PanelContent, Type = typeof(FrameworkElement))]
    [TemplateVisualState(GroupName = CollapsiblePanel.CommonStates, Name = CollapsiblePanel.Expand)]
    [TemplateVisualState(GroupName = CollapsiblePanel.CommonStates, Name = CollapsiblePanel.Collapse)]
    public partial class CollapsiblePanel : ContentControl
    {
        private const string ExpandCollapseButton = "ExpandCollapseButton";
        private const string ContentContainer = "ContentContainer";
        private const string PanelContent = "PanelContent";
        private const string CommonStates = "CommonStates";
        private const string Collapse = "Collapse";
        private const string Expand = "Expand";

        private string _RollUpStoryboardName = null;
        private string _RollDownStoryboardName = null;
        private FrameworkElement _expandCollapseButton;
        private Panel _contentContainer;
        private FrameworkElement _content;

        public CollapsiblePanel()
        {
            DefaultStyleKey = typeof(CollapsiblePanel);
        }

        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();

            _expandCollapseButton = GetTemplateChild(ExpandCollapseButton) as FrameworkElement;
            _contentContainer = GetTemplateChild(ContentContainer) as Panel;
            _content = GetTemplateChild(PanelContent) as FrameworkElement;

            if (_contentContainer != null)
            {
                _contentContainer.SizeChanged += new SizeChangedEventHandler(_contentContainer_SizeChanged);
            }

            if (_content != null)
            {
                _content.SizeChanged += new SizeChangedEventHandler(_content_SizeChanged);
            }

            if (_expandCollapseButton != null)
            {
                if (_expandCollapseButton is ButtonBase)
                {
                    (_expandCollapseButton as ButtonBase).Click += new RoutedEventHandler(_expandCollapseButton_Click);
                }
                else
                {
                    _expandCollapseButton.MouseLeftButtonUp += new MouseButtonEventHandler(_expandCollapseButton_MouseLeftButtonUp);
                }
            }
        }

        void _contentContainer_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            Panel container = sender as Panel;
            if (container != null)
            {
                RectangleGeometry rg = new RectangleGeometry();
                Rect r = new Rect(0, 0, container.ActualWidth, container.ActualHeight);
                RectangleGeometry clip = new RectangleGeometry();
                rg.Rect = r;
                container.Clip = rg;
            }
        }

        void _content_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            FrameworkElement content = sender as FrameworkElement;
            if (content != null)
            {
                TransformGroup tGroup = new TransformGroup();
                TranslateTransform translate = new TranslateTransform();
                translate.SetValue(FrameworkElement.NameProperty, "RollTransform" + Guid.NewGuid().ToString());
                if (IsExpanded)
                {
                    translate.Y = 0;
                    VisualStateManager.GoToState(this as Control, Expand, false);
                }
                else
                {
                    translate.Y = -content.ActualHeight;
                    VisualStateManager.GoToState(this as Control, Collapse, false);
                }

                tGroup.Children.Add(translate);
                content.RenderTransform = tGroup;

                _RollUpStoryboardName = "RollUp" + Guid.NewGuid().ToString();
                _RollDownStoryboardName = "RollDown" + Guid.NewGuid().ToString();

                _SetupYTranslationStoryboard(translate, _RollUpStoryboardName, -content.ActualHeight);
                _SetupYTranslationStoryboard(translate, _RollDownStoryboardName, 0);
            }
        }

        void _SetupYTranslationStoryboard(TranslateTransform transform, string sbName, double translation)
        {
            if (Resources.Contains(sbName))
            {
                Storyboard sb = Resources[sbName] as Storyboard;
                DoubleAnimationUsingKeyFrames anim = sb.Children[0] as DoubleAnimationUsingKeyFrames;
                SplineDoubleKeyFrame keyFrame = anim.KeyFrames[0] as SplineDoubleKeyFrame;
                keyFrame.Value = translation;
            }
            else
            {
                Storyboard sb = new Storyboard();
                sb.SetValue(FrameworkElement.NameProperty, sbName);
                DoubleAnimationUsingKeyFrames anim = new DoubleAnimationUsingKeyFrames();
                sb.Children.Add(anim);
                Storyboard.SetTarget(anim, transform);
                Storyboard.SetTargetProperty(anim, new PropertyPath("Y"));
                anim.BeginTime = new TimeSpan(0, 0, 0);
                SplineDoubleKeyFrame keyFrame = new SplineDoubleKeyFrame();
                KeySpline spline = new KeySpline();
                spline.ControlPoint1 = new Point(0, 1);
                spline.ControlPoint2 = new Point(1, 1);
                keyFrame.KeySpline = spline;
                keyFrame.KeyTime = new TimeSpan(0, 0, 1);
                keyFrame.Value = translation;
                anim.KeyFrames.Add(keyFrame);
                Resources.Add(sbName, sb);
            }
        }

        void _expandCollapseButton_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            IsExpanded = !IsExpanded;
        }

        void _expandCollapseButton_Click(object sender, RoutedEventArgs e)
        {
            IsExpanded = !IsExpanded;
        }

        public string Title
        {
            get { return (string)GetValue(TitleProperty); }
            set { SetValue(TitleProperty, value); }
        }

        // Using a DependencyProperty as the backing store for Title.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty TitleProperty =
            DependencyProperty.Register("Title", typeof(string), typeof(CollapsiblePanel), null);

        public bool IsExpanded
        {
            get
            {
                return (bool)GetValue(IsExpandedProperty);
            }

            set
            {
                SetValue(IsExpandedProperty, value);
            }
        }

        // Using a DependencyProperty as the backing store for IsExpanded.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty IsExpandedProperty =
            DependencyProperty.Register("IsExpanded", typeof(bool), typeof(CollapsiblePanel), new PropertyMetadata(new PropertyChangedCallback(IsExpandedChanged)));

        private static void IsExpandedChanged(DependencyObject o, DependencyPropertyChangedEventArgs e)
        {
            bool expanded = (bool)e.NewValue;
            CollapsiblePanel panel = o as CollapsiblePanel;
            if (panel != null)
            {
                if (expanded)
                {
                    _ChangeState(panel, Expand, panel._RollDownStoryboardName);
                }
                else
                {
                    _ChangeState(panel, Collapse, panel._RollUpStoryboardName);
                }
            }
        }

        private static void _ChangeState(CollapsiblePanel panel, string goToState, string stateStoryboardName)
        {
            if (panel != null && goToState != null)
            {
                VisualStateManager.GoToState((panel as Control), goToState, true);
            }

            if (stateStoryboardName != null)
            {
                Storyboard sb = (panel as FrameworkElement).Resources[stateStoryboardName] as Storyboard;
                if (sb != null)
                {
                    sb.Begin();
                }
            }
        }
    }
}
