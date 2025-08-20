package edu.pahana.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class LoginServletTest {

    @InjectMocks
    private LoginServlet loginServlet;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private HttpSession session;

    @Mock
    private RequestDispatcher requestDispatcher;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testDoPostSuccess() throws ServletException, IOException {
        // Arrange
        when(request.getParameter("username")).thenReturn("admin");
        when(request.getParameter("password")).thenReturn("123");
        when(request.getSession(true)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(null);

        // Act
        loginServlet.doPost(request, response);

        // Assert with custom messages
        verify(session, times(1)).setAttribute("user", "admin");
        assertTrue(true, "Login successful: Session attribute 'user' set to 'admin'");
        verify(response, times(1)).sendRedirect("dashboard.jsp");
        assertTrue(true, "Login successful: Redirected to dashboard.jsp");
        verify(request, never()).setAttribute(eq("error"), anyString());
        verify(request, never()).getRequestDispatcher(anyString());
        System.out.println("testDoPostSuccess: PASSED");
    }

    @Test
    void testDoPostFailure() throws ServletException, IOException {
        // Arrange
        when(request.getParameter("username")).thenReturn("wrong");
        when(request.getParameter("password")).thenReturn("wrong");
        when(request.getRequestDispatcher("index.jsp")).thenReturn(requestDispatcher);

        // Act
        loginServlet.doPost(request, response);

        // Assert with custom messages
        verify(request, times(1)).setAttribute("error", "Invalid credentials");
        assertTrue(true, "Login failed: Error attribute set to 'Invalid credentials'");
        verify(request, times(1)).getRequestDispatcher("index.jsp");
        verify(requestDispatcher, times(1)).forward(request, response);
        assertTrue(true, "Login failed: Forwarded to index.jsp");
        verify(response, never()).sendRedirect(anyString());
        verify(request, never()).getSession(true);
        System.out.println("testDoPostFailure: PASSED");
    }

    @Test
    void testDoPostNullCredentials() throws ServletException, IOException {
        // Arrange
        when(request.getParameter("username")).thenReturn(null);
        when(request.getParameter("password")).thenReturn(null);
        when(request.getRequestDispatcher("index.jsp")).thenReturn(requestDispatcher);

        // Act
        loginServlet.doPost(request, response);

        // Assert with custom messages
        verify(request, times(1)).setAttribute("error", "Invalid credentials");
        assertTrue(true, "Null credentials: Error attribute set to 'Invalid credentials'");
        verify(requestDispatcher, times(1)).forward(request, response);
        assertTrue(true, "Null credentials: Forwarded to index.jsp");
        System.out.println("testDoPostNullCredentials: PASSED");
    }
}