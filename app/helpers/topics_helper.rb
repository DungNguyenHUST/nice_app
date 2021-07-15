module TopicsHelper
    def cal_topic_trend_point(topic)
        topic_follow_count = topic.topic_follows.count
        return topic_follow_count
    end
end
