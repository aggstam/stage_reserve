package com.stagereserve.services;

import com.stagereserve.models.Attendee;
import com.stagereserve.repositories.AttendeeRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AttendeeService {

    @Resource
    private AttendeeRepository attendeeRepository;

    public Attendee save(Attendee attendee) {
        return attendeeRepository.save(attendee);
    }

}
