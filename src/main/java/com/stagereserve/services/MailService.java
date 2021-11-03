package com.stagereserve.services;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.logging.Logger;

@Service
public class MailService {

    private static final Logger logger = Logger.getLogger(MailService.class.getName());

    @Resource
    private JavaMailSender emailSender;

    @Async
    public void sendEmail(String subject, String recipient, String message) {
        send(subject, recipient, message);
    }

    @Async
    public void sendEmail(String subject, String[] recipients, String message) {
        for (String recipient : recipients) {
            send(subject, recipient, message);
        }
    }

    private void send(String subject, String recipient, String message) {
        try {
            MimeMessage mimeMessage = emailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "utf-8");
            helper.setSubject(subject);
            helper.setFrom("stage.reserve@gmail.com");
            helper.setTo(recipient);
            helper.setText(message, true);
            emailSender.send(mimeMessage);
        } catch (MessagingException e) {
            logger.info("Exception: " + e.getMessage());
        }
    }

}
