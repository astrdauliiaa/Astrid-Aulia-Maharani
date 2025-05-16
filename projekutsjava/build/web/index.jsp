<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Film" %>
<%@ page session="true" %>
<%
    ArrayList<Film> daftarFilm = new ArrayList<>();
    daftarFilm.add(new Film("Jumbo", "Animasi", 148, 45000, new String[]{"12:00", "15:00", "18:00"}));
    daftarFilm.add(new Film("Mungkin Kita Perlu Waktu", "Drama", 169, 40000, new String[]{"13:00", "16:00", "19:00"}));
    session.setAttribute("daftarFilm", daftarFilm);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Daftar Film</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to bottom right, #e6f9ec, #d0f0d9);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
            padding-top: 60px; /* ruang header fixed */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #1a1a1a;
        }
        /* Header fixed dengan 3 bagian */
        .page-header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 60px;
            background: transparent;
            display: flex;
            align-items: center;
            padding: 0 20px;
            z-index: 1000;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .logo {
            font-size: 32px;
            font-weight: bold;
            color: #1f5133;
            letter-spacing: 2px;
            cursor: default;
            flex: 0 0 auto;
        }
        .page-title {
            font-weight: bold;
            font-size: 22px;
            color: #1f5133;
            letter-spacing: 1.5px;
            flex: 1 1 auto;
            text-align: center;
            user-select: none;
        }
        .search-box {
            flex: 0 0 300px;
        }
        .search-box input {
            width: 100%;
            border: 2px solid #28a745;
            border-radius: 12px;
            padding: 6px 12px;
            font-size: 16px;
            outline: none;
            transition: box-shadow 0.3s;
        }
        .search-box input:focus {
            box-shadow: 0 0 6px #28a745;
        }
        .container {
            max-width: 1100px;
            margin-top: 20px;
            position: relative;
        }
        .film-card {
            cursor: pointer;
        }
        .card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            background-color: #ffffff;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            transition: transform 0.2s ease;
        }
        .card:hover {
            transform: scale(1.03);
        }
        .card-img-top {
            height: 480px;
            object-fit: cover;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }
        .card-body {
            padding: 20px;
            background-color: #ffffff;
            text-align: center;
        }
        .card-title {
            color: #1f5133;
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 10px;
        }
        .card-text {
            font-size: 14px;
            color: #333333;
            line-height: 1.4;
        }
        .btn-pesan {
            margin-top: 50px;
            text-align: center;
        }
        .btn-custom {
            background-color: #1f5133;
            border: none;
            color: white;
            font-weight: 600;
            font-size: 18px;
            padding: 10px 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(31,81,51,0.4);
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        .btn-custom:hover {
            background-color: #145a32;
            color: white;
            text-decoration: none;
        }

        /* Emoji background styles */
        .emoji-bg {
            position: fixed;
            font-size: 4rem;
            opacity: 0.15;
            user-select: none;
            pointer-events: none;
            z-index: 0;
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

        /* Pesan film tidak tersedia */
        #noFilmMessage {
            display: none;
            text-align: center;
            font-size: 24px;
            color: #b22222;
            margin-top: 40px;
            font-weight: bold;
        }
    </style>
</head>
<body>

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

    <!-- Header fixed: logo - title - search -->
    <div class="page-header">
        <div class="logo">シネマ</div>
        <div class="page-title">Daftar Film</div>
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="Cari film...">
        </div>
    </div>

    <div class="container">
        <div class="row g-4 justify-content-center" id="filmList">
            <% for (Film film : daftarFilm) { %>
                <div class="col-sm-10 col-md-5 col-lg-4 film-card" onclick="location.href='formPesan.jsp'">
                    <div class="card h-100">
                        <img src="images/<%= film.judul.replaceAll(" ", "").toLowerCase() %>.jpg" 
                             class="card-img-top" alt="<%= film.judul %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= film.judul %></h5>
                            <p class="card-text">
                                <strong>Genre:</strong> <%= film.genre %><br>
                                <strong>Durasi:</strong> <%= film.durasi %> menit<br>
                                <strong>Harga:</strong> Rp.<%= String.format("%,d", film.harga).replace(',', '.') %><br>
                                <strong>Jam:</strong> <%= String.join(", ", film.jamTayang) %>
                            </p>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>

        <!-- Pesan jika film tidak ditemukan -->
        <div id="noFilmMessage">Film tidak tersedia.</div>

        <!-- Tombol Pesan Tiket -->
        <div class="btn-pesan">
            <a href="formPesan.jsp" class="btn btn-custom">Pesan Tiket</a>
        </div>
    </div>

    <script>
        const searchInput = document.getElementById('searchInput');
        const filmCards = document.querySelectorAll('.film-card');
        const noFilmMessage = document.getElementById('noFilmMessage');

        searchInput.addEventListener('input', function() {
            const query = this.value.toLowerCase();
            let visibleCount = 0;
            filmCards.forEach(card => {
                const title = card.querySelector('.card-title').textContent.toLowerCase();
                if (title.includes(query)) {
                    card.style.display = '';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            noFilmMessage.style.display = (visibleCount === 0) ? 'block' : 'none';
        });
    </script>

</body>
</html>