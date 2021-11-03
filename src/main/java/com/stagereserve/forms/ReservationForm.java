package com.stagereserve.forms;

import org.springframework.lang.Nullable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class ReservationForm {

    @NotNull
    @Size(min=2, max=20)
    private String event;

    @NotNull
    private String datesTimeString;

    @Nullable
    private String invites;

    public ReservationForm() {}

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public String getDatesTimeString() {
        return datesTimeString;
    }

    public void setDatesTimeString(String datesTimeString) {
        this.datesTimeString = datesTimeString;
    }

    public String getInvites() {
        return invites;
    }

    public void setInvites(String invites) {
        this.invites = invites;
    }

}
