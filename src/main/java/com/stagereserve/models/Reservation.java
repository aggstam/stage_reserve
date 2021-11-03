package com.stagereserve.models;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(nullable = false)
    private Stage stage;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(nullable=false)
    private User createdBy;

    @Column(nullable = false)
    private String event;

    @Column(nullable = false)
    private Date reserveFrom;

    @Column(nullable = false)
    private Date reserveTo;

    @OneToMany(cascade={CascadeType.REMOVE}, mappedBy = "reservation", fetch = FetchType.EAGER)
    private List<Attendee> attendees;

    public Reservation() {}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Stage getStage() {
        return stage;
    }

    public void setStage(Stage stage) {
        this.stage = stage;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public Date getReserveFrom() {
        return reserveFrom;
    }

    public void setReserveFrom(Date reserveFrom) {
        this.reserveFrom = reserveFrom;
    }

    public Date getReserveTo() {
        return reserveTo;
    }

    public void setReserveTo(Date reserveTo) {
        this.reserveTo = reserveTo;
    }

    public List<Attendee> getAttendees() {
        return attendees;
    }

    public void setAttendees(List<Attendee> attendees) {
        this.attendees = attendees;
    }

}
