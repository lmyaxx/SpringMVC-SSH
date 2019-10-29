package com.dhu.pojo;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
public class News {
    private int newsId;
    private Timestamp releaseTime;
    private int viewNum;
    private String content;
    private String title;
    private String picId;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "news_id", nullable = false)
    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    @Basic
    @Column(name = "release_time", nullable = false)
    public Timestamp getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(Timestamp releaseTime) {
        this.releaseTime = releaseTime;
    }

    @Basic
    @Column(name = "view_num", nullable = false)
    public int getViewNum() {
        return viewNum;
    }

    public void setViewNum(int viewNum) {
        this.viewNum = viewNum;
    }

    @Basic
    @Column(name = "content", nullable = false, length = -1)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Basic
    @Column(name = "title", nullable = false, length = -1)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Basic
    @Column(name = "pic_id", nullable = true, length = 50)
    public String getPicId() {
        return picId;
    }

    public void setPicId(String picId) {
        this.picId = picId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        News news = (News) o;

        if (newsId != news.newsId) return false;
        if (viewNum != news.viewNum) return false;
        if (releaseTime != null ? !releaseTime.equals(news.releaseTime) : news.releaseTime != null) return false;
        if (content != null ? !content.equals(news.content) : news.content != null) return false;
        if (title != null ? !title.equals(news.title) : news.title != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = newsId;
        result = 31 * result + (releaseTime != null ? releaseTime.hashCode() : 0);
        result = 31 * result + viewNum;
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (title != null ? title.hashCode() : 0);
        return result;
    }
}
