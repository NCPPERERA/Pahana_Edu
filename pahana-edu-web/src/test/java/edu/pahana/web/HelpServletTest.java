package edu.pahana.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

class HelpServletTest {

    private static final Logger logger = LoggerFactory.getLogger(HelpServletTest.class);

    @InjectMocks
    private HelpServlet helpServlet;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private RequestDispatcher requestDispatcher;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        when(request.getRequestDispatcher("help.jsp")).thenReturn(requestDispatcher);
    }

    @Test
    @DisplayName("doGet forwards to help.jsp")
    void testDoGet() throws ServletException, IOException {
        // Act
        helpServlet.doGet(request, response);

        // Assert
        verify(request, times(1)).getRequestDispatcher("help.jsp");
        verify(requestDispatcher, times(1)).forward(request, response);
        logger.info("testDoGet: PASSED");
    }
}