<%-- 
    Document   : formPesan
    Created on : May 16, 2025, 1:46:15 PM
    Author     : Astrid
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Film" %>
<%@ page session="true" %>
<%
    ArrayList<Film> indexFilm = (ArrayList<Film>) session.getAttribute("daftarFilm");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Form Pemesanan Tiket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            background: linear-gradient(to bottom right, #e6f9ec, #d0f0d9);
            overflow: hidden; /* supaya tidak ada scroll */
            font-family: Arial, sans-serif;
        }

        body {
            display: flex;
            justify-content: center; /* center horizontal */
            align-items: center;     /* center vertical */
            padding: 20px; /* sedkit ruang biar box ga mepet banget ke tepi layar */
            box-sizing: border-box;
        }

        .page-header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 60px;
            background: transparent;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            z-index: 1000;
            font-family: Arial, sans-serif;
        }

        .logo {
            font-size: 32px;
            font-weight: bold;
            color: #1f5133;
            letter-spacing: 2px;
        }

        .beranda-btn {
            font-size: 16px;
            font-weight: 600;
            color: #1f5133;
            text-decoration: none;
            border: 2px solid #1f5133;
            padding: 6px 16px;
            border-radius: 8px;
            transition: background-color 0.3s, color 0.3s;
        }

        .beranda-btn:hover {
            background-color: #1f5133;
            color: #fff;
            text-decoration: none;
        }

        /* Box form */
        .form-box {
            background: white;
            padding: 30px 30px 25px 30px;
            border-radius: 20px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            width: 450px;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
            z-index: 1;
            box-sizing: border-box;
        }

        .form-title {
            font-weight: bold;
            font-size: 24px;
            color: #1f5133;
            letter-spacing: 1.5px;
            margin-bottom: 25px;
            text-align: center;
        }

        label {
            font-weight: 500;
        }

        .emoji-bg {
            position: absolute;
            font-size: 100px;
            opacity: 0.15;
            color: #68a07e;
            z-index: 0;
            pointer-events: none;
        }

        .emoji-bg.one   { top: 10%;  left: 5%; transform: rotate(-15deg); }
        .emoji-bg.two   { bottom: 20%; right: 5%; transform: rotate(10deg); }
        .emoji-bg.three { top: 55%; right: 20%; transform: rotate(-20deg); }
        .emoji-bg.four  { bottom: 5%; left: 10%; transform: rotate(5deg); }
        .emoji-bg.five  { top: 30%; left: 40%; transform: rotate(15deg); }
        .emoji-bg.six   { top: 20%; right: 30%; transform: rotate(-10deg); }
        .emoji-bg.seven { bottom: 30%; left: 25%; transform: rotate(25deg); }
        .emoji-bg.eight { top: 70%; right: 10%; transform: rotate(-5deg); }
        .emoji-bg.nine  { bottom: 10%; right: 35%; transform: rotate(15deg); }
        .emoji-bg.ten   { top: 45%; left: 5%; transform: rotate(-25deg); }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="page-header">
        <div class="logo">シネマ</div>
        <a href="index.jsp" class="beranda-btn">Beranda</a>
    </div>

    <!-- Form Box -->
    <div class="form-box">
        <div class="form-title">Form Pemesanan Tiket</div>
        <form action="struk.jsp" method="post">
            <div class="mb-3">
                <label>Nama Pemesan:</label>
                <input type="text" name="nama" class="form-control" placeholder="Masukkan nama Anda" required>
            </div>
            <div class="mb-3">
                <label>Jumlah Tiket:</label>
                <input type="number" name="jumlah" class="form-control" placeholder="Contoh: 2" required>
            </div>
            <div class="mb-3">
                <label>Film:</label>
                <select name="filmIndex" class="form-control" id="filmSelect" required>
                    <% for (int i = 0; i < indexFilm.size(); i++) {
                        Film f = indexFilm.get(i);
                        String jamStr = String.join(",", f.jamTayang); %>
                        <option value="<%= i %>" data-jam="<%= jamStr %>"><%= f.judul %></option>
                    <% } %>
                </select>
            </div>
            <div class="mb-3">
                <label>Jam Tayang:</label>
                <select name="jam" class="form-control" id="jamSelect" required>
                    <option value="">--Pilih Jam--</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success w-100 mt-3 shadow-sm">Proses Pemesanan</button>
        </form>
    </div>

    <!-- Emoji Dekoratif -->
    <div class="emoji-bg one">🎬</div>
    <div class="emoji-bg two">🍿</div>
    <div class="emoji-bg three">🎥</div>
    <div class="emoji-bg four">🎞</div>
    <div class="emoji-bg five">📽</div>
    <div class="emoji-bg six">⭐</div>
    <div class="emoji-bg seven">🎟</div>
    <div class="emoji-bg eight">✨</div>
    <div class="emoji-bg nine">📺</div>
    <div class="emoji-bg ten">🎧</div>

    <script>
        const filmSelect = document.getElementById('filmSelect');
        const jamSelect = document.getElementById('jamSelect');

        function updateJamTayang() {
            const selectedOption = filmSelect.options[filmSelect.selectedIndex];
            const jamList = selectedOption.getAttribute('data-jam').split(",");
            jamSelect.innerHTML = '<option value="">--Pilih Jam--</option>';
            jamList.forEach(jam => {
                const option = document.createElement("option");
                option.value = jam;
                option.textContent = jam;
                jamSelect.appendChild(option);
            });
        }

        filmSelect.addEventListener('change', updateJamTayang);
        window.addEventListener('DOMContentLoaded', updateJamTayang);
    </script>

</body>
</html>