package edu.pahana.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

import static org.mockito.Mockito.*;

class LogoutServletTest {

    private static final Logger logger = LoggerFactory.getLogger(LogoutServletTest.class);

    @InjectMocks
    private LogoutServlet logoutServlet;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private HttpSession session;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    @DisplayName("doGet invalidates existing session and redirects to index.jsp")
    void testDoGetWithSession() throws IOException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);

        // Act
        logoutServlet.doGet(request, response);

        // Assert
        verify(request, times(1)).getSession(false);
        verify(session, times(1)).invalidate();
        verify(response, times(1)).sendRedirect("index.jsp");
        logger.info("testDoGetWithSession: PASSED");
    }

    @Test
    @DisplayName("doGet redirects to index.jsp when no session exists")
    void testDoGetWithoutSession() throws IOException {
        // Arrange
        when(request.getSession(false)).thenReturn(null);

        // Act
        logoutServlet.doGet(request, response);

        // Assert
        verify(request, times(1)).getSession(false);
        verify(session, never()).invalidate();
        verify(response, times(1)).sendRedirect("index.jsp");
        logger.info("testDoGetWithoutSession: PASSED");
    }
}