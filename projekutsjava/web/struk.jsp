<%-- 
    Document   : struk
    Created on : May 16, 2025, 1:47:39 PM
    Author     : Astrid
--%>

<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="model.Film" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String nama = request.getParameter("nama");
    int jumlah = Integer.parseInt(request.getParameter("jumlah"));
    int filmIndex = Integer.parseInt(request.getParameter("filmIndex"));
    String jam = request.getParameter("jam");

    ArrayList<Film> daftarFilm = (ArrayList<Film>) session.getAttribute("daftarFilm");
    Film filmDipilih = daftarFilm.get(filmIndex);

    boolean jamValid = Arrays.asList(filmDipilih.jamTayang).contains(jam);
    if (!jamValid) {
%>
    <script>
        alert("Jam tayang tidak sesuai dengan film yang dipilih.");
        window.location.href = "formPesan.jsp";
    </script>
<%
        return;
    }

    int totalHarga = jumlah * filmDipilih.harga;

    DecimalFormat df = new DecimalFormat("#,###");
    String totalHargaFormatted = df.format(totalHarga).replace(',', '.');
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Struk Pemesanan</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <style>
        body {
            background: linear-gradient(to bottom right, #e6f9ec, #d0f0d9);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }
        /* Header atas */
        .header-top {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 60px;
            background: transparent;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 30px;
            z-index: 20;
            user-select: none;
        }
        .logo-shinema {
            font-size: 36px;
            font-weight: 900;
            color: #1f5133;
            font-family: 'Arial Black', Arial, sans-serif;
            letter-spacing: 3px;
            cursor: default;
        }
        .btn-beranda {
            background-color: #28a745;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .btn-beranda:hover {
            background-color: #1e7e34;
            text-decoration: none;
            color: white;
        }

        /* Box struk */
        .struk-box {
            max-width: 600px;
            margin: 120px auto 80px;
            background: #fff;
            padding: 35px 30px;
            border-radius: 20px;
            box-shadow: 0 12px 25px rgba(0,0,0,0.15);
            position: relative;
            z-index: 10;
        }
        .struk-box h3 {
            text-align: center;
            color: #000;
            margin-bottom: 25px;
            border-bottom: 2px solid #000;
            padding-bottom: 10px;
        }
        .table th, .table td {
            color: #000;
        }
        .btn-outline-success {
            border-radius: 30px;
            padding: 10px 25px;
        }

        /* Emoji background banyak */
        .emoji-bg {
            position: absolute;
            font-size: 60px;
            opacity: 0.15;
            z-index: 0;
            user-select: none;
            pointer-events: none;
            transition: transform 0.3s ease;
        }
        .emoji-bg:hover {
            transform: scale(1.2) rotate(10deg);
            opacity: 0.3;
        }
        .emoji-bg.one { top: 10%; left: 5%; transform: rotate(-20deg); }
        .emoji-bg.two { bottom: 10%; right: 10%; transform: rotate(15deg); }
        .emoji-bg.three { top: 50%; right: 30%; transform: rotate(-25deg); }
        .emoji-bg.four { bottom: 40%; left: 40%; transform: rotate(10deg); font-size: 75px; }
        .emoji-bg.five { top: 70%; left: 20%; transform: rotate(-15deg); font-size: 80px; }
        .emoji-bg.six { top: 30%; left: 80%; transform: rotate(5deg); font-size: 65px; }
        .emoji-bg.seven { bottom: 20%; left: 25%; transform: rotate(-10deg); font-size: 50px; }
        .emoji-bg.eight { top: 80%; right: 50%; transform: rotate(20deg); font-size: 55px; }
        .emoji-bg.nine { top: 15%; right: 60%; transform: rotate(-30deg); font-size: 70px; }
        .emoji-bg.ten { bottom: 5%; left: 70%; transform: rotate(25deg); font-size: 60px; }
    </style>
</head>
<body>
    <div class="header-top">
        <div class="logo-shinema">シネマ</div>
        <a href="index.jsp" class="btn-beranda">Beranda</a>
    </div>

    <!-- Dekorasi Emoji Bioskop -->
    <div class="emoji-bg one">🎬</div>
    <div class="emoji-bg two">🍿</div>
    <div class="emoji-bg three">🎥</div>
    <div class="emoji-bg four">🎞</div>
    <div class="emoji-bg five">✨</div>
    <div class="emoji-bg six">🎟</div>
    <div class="emoji-bg seven">📽</div>
    <div class="emoji-bg eight">🎭</div>
    <div class="emoji-bg nine">🎫</div>
    <div class="emoji-bg ten">🌟</div>

    <div class="struk-box">
        <h3>Struk Pemesanan</h3>
        <table class="table table-borderless">
            <tr><th>Nama Pemesan</th><td><%= nama %></td></tr>
            <tr><th>Film</th><td><%= filmDipilih.judul %></td></tr>
            <tr><th>Jam Tayang</th><td><%= jam %></td></tr>
            <tr><th>Jumlah Tiket</th><td><%= jumlah %> tiket</td></tr>
            <tr><th>Total Harga</th><td><strong>Rp <%= totalHargaFormatted %></strong></td></tr>
        </table>
        <div class="text-center mt-4">
            <a href="index.jsp" class="btn btn-outline-success">Kembali ke Daftar Film</a>
        </div>
    </div>
</body>
</html>