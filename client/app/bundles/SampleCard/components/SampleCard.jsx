import React, { PropTypes } from 'react';

export default class SampleCard extends React.Component {

  /**
   * @param props - Comes from your rails view.
   * @param _railsContext - Comes from React on Rails
   */
  constructor(props, _railsContext) {
    super(props);
    this.state = {};
  }

  static propTypes = {
    widgetId: React.PropTypes.string,
    href: React.PropTypes.string,
    twitterId: React.PropTypes.string,
    limit: React.PropTypes.number,
    width: React.PropTypes.oneOfType([React.PropTypes.number, React.PropTypes.string]),
    hegiht: React.PropTypes.oneOfType([React.PropTypes.number, React.PropTypes.string])
  };
  
  static get defaultProps() {
    return {
      widgetId: "717706293973094400",
      href: "https://twitter.com/gakufes_jp",
      twitterId: "gakufes_jp",
      limit: 2
    };
  }

  componentDidMount() {
    if (window.twttr) {
      $(this.renderTimelines.bind(this));
    } else {
      $.getScript("//platform.twitter.com/widgets.js", this.renderTimelines.bind(this));
    }
  }

  renderTimelines() {
    $(this.refs.container).empty();
    twttr.widgets.createTimeline(this.props.widgetId, this.refs.container, {
      // パラメータ参照: https://dev.twitter.com/ja/web/embedded-timelines/parameters
      chrome: "nofooter noheader noborders transparent",
      lang: "ja",
      tweetLimit: this.props.limit,
      width: this.props.width,
      height: this.props.height
    });
  }

  render() {
    return (
      <div>
        <a
          ref="container"
          href={this.props.href}
          data-chrome="nofooter noheader noborders transparent">
          @{this.props.twitterId}さんのツイート
        </a>
      </div>
    );
  }
}
