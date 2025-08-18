package edu.pahana.web;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class RestClient {
    private static final String BASE = System.getProperty("service.base", "http://localhost:8080/pahana-edu-service/api/");

    public static String get(String path) throws IOException {
        HttpURLConnection c = (HttpURLConnection) new URL(BASE + path).openConnection();
        c.setRequestMethod("GET");
        return read(c);
    }
    public static String post(String path, String json) throws IOException {
        HttpURLConnection c = (HttpURLConnection) new URL(BASE + path).openConnection();
        c.setRequestMethod("POST");
        c.setRequestProperty("Content-Type", "application/json");
        c.setDoOutput(true);
        try (OutputStream os = c.getOutputStream()) {
            os.write(json.getBytes(StandardCharsets.UTF_8));
        }
        return read(c);
    }
    public static String put(String path, String json) throws IOException {
        HttpURLConnection c = (HttpURLConnection) new URL(BASE + path).openConnection();
        c.setRequestMethod("PUT");
        c.setRequestProperty("Content-Type", "application/json");
        c.setDoOutput(true);
        try (OutputStream os = c.getOutputStream()) {
            os.write(json.getBytes(StandardCharsets.UTF_8));
        }
        return read(c);
    }
    public static String delete(String path) throws IOException {
        HttpURLConnection c = (HttpURLConnection) new URL(BASE + path).openConnection();
        c.setRequestMethod("DELETE");
        return read(c);
    }
    private static String read(HttpURLConnection c) throws IOException {
        try (InputStream in = c.getResponseCode() >= 400 ? c.getErrorStream() : c.getInputStream()) {
            if (in == null) return "";
            return new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
    }

    static void put(String customers, String customerId, String toString) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
