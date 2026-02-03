// =============================================
// Importação e criação do modelo completo
// =============================================

WITH '[
  {"user_id":"u001","nome":"Ana Silva","musicas_escutadas":["Shape of You","Blinding Lights","Levitating"],"artistas_favoritos":["Ed Sheeran","The Weeknd","Dua Lipa"],"generos":["pop","dance-pop"]},
  {"user_id":"u002","nome":"Bruno Costa","musicas_escutadas":["Bohemian Rhapsody","Sweet Child O\' Mine"],"artistas_favoritos":["Queen","Guns N\' Roses"],"generos":["rock","classic rock"]},
  {"user_id":"u003","nome":"Carla Mendes","musicas_escutadas":["Bad Guy","Ocean Eyes","Happier Than Ever"],"artistas_favoritos":["Billie Eilish"],"generos":["indie pop","electropop"]},
  {"user_id":"u004","nome":"Diego Santos","musicas_escutadas":["T.N.T.","Highway to Hell"],"artistas_favoritos":["AC/DC"],"generos":["hard rock"]},
  {"user_id":"u005","nome":"Eduarda Lima","musicas_escutadas":["Anti-Hero","Cruel Summer","Lavender Haze"],"artistas_favoritos":["Taylor Swift"],"generos":["pop"]},
  {"user_id":"u006","nome":"Felipe Rocha","musicas_escutadas":["Lose Yourself","Stan","Without Me"],"artistas_favoritos":["Eminem"],"generos":["hip hop","rap"]},
  {"user_id":"u007","nome":"Gabriela Souza","musicas_escutadas":["Flowers","Die For You"],"artistas_favoritos":["Miley Cyrus","The Weeknd"],"generos":["pop"]},
  {"user_id":"u008","nome":"Henrique Alves","musicas_escutadas":["Smells Like Teen Spirit","Come As You Are"],"artistas_favoritos":["Nirvana"],"generos":["grunge","alternative rock"]},
  {"user_id":"u009","nome":"Isabela Ferreira","musicas_escutadas":["drivers license","good 4 u"],"artistas_favoritos":["Olivia Rodrigo"],"generos":["pop punk","pop"]},
  {"user_id":"u010","nome":"João Pedro","musicas_escutadas":["God\' \'s Plan","One Dance"],"artistas_favoritos":["Drake"],"generos":["hip hop","rap"]},
  {"user_id":"u011","nome":"Larissa Gomes","musicas_escutadas":["As It Was","Watermelon Sugar"],"artistas_favoritos":["Harry Styles"],"generos":["pop rock"]},
  {"user_id":"u012","nome":"Matheus Lima","musicas_escutadas":["Rádio","Toxic"],"artistas_favoritos":["Britney Spears"],"generos":["pop"]},
  {"user_id":"u013","nome":"Natália Ribeiro","musicas_escutadas":["Umbrella","Diamonds"],"artistas_favoritos":["Rihanna"],"generos":["R&B","pop"]},
  {"user_id":"u014","nome":"Otávio Martins","musicas_escutadas":["Enter Sandman","Nothing Else Matters"],"artistas_favoritos":["Metallica"],"generos":["heavy metal"]},
  {"user_id":"u015","nome":"Patrícia Dias","musicas_escutadas":["Montero","Industry Baby"],"artistas_favoritos":["Lil Nas X"],"generos":["hip hop","pop rap"]},
  {"user_id":"u016","nome":"Rafael Oliveira","musicas_escutadas":["Yellow","Viva La Vida"],"artistas_favoritos":["Coldplay"],"generos":["alternative rock","pop rock"]},
  {"user_id":"u017","nome":"Sofia Almeida","musicas_escutadas":["Thank U, Next","7 rings"],"artistas_favoritos":["Ariana Grande"],"generos":["pop","R&B"]},
  {"user_id":"u018","nome":"Thiago Barros","musicas_escutadas":["Back in Black","Thunderstruck"],"artistas_favoritos":["AC/DC"],"generos":["hard rock"]},
  {"user_id":"u019","nome":"Úrsula Castro","musicas_escutadas":["Bad Habits","I Don\' \'t Care"],"artistas_favoritos":["Ed Sheeran"],"generos":["pop"]},
  {"user_id":"u020","nome":"Vinícius Mendes","musicas_escutadas":["Sicko Mode","goosebumps"],"artistas_favoritos":["Travis Scott"],"generos":["trap","hip hop"]},
  {"user_id":"u021","nome":"Wanda Teixeira","musicas_escutadas":["Positions","34+35"],"artistas_favoritos":["Ariana Grande"],"generos":["pop"]},
  {"user_id":"u022","nome":"Xavier Nogueira","musicas_escutadas":["Hotel California","Take It Easy"],"artistas_favoritos":["Eagles"],"generos":["classic rock"]},
  {"user_id":"u023","nome":"Yasmin Pires","musicas_escutadas":["Easy On Me","Someone Like You"],"artistas_favoritos":["Adele"],"generos":["soul","pop"]},
  {"user_id":"u024","nome":"Zeca Rodrigues","musicas_escutadas":["Juice","Good as Hell"],"artistas_favoritos":["Lizzo"],"generos":["pop","R&B"]},
  {"user_id":"u025","nome":"Amanda Torres","musicas_escutadas":["Peaches","Intentions"],"artistas_favoritos":["Justin Bieber"],"generos":["pop"]},
  {"user_id":"u026","nome":"Bernardo Farias","musicas_escutadas":["Black Dog","Stairway to Heaven"],"artistas_favoritos":["Led Zeppelin"],"generos":["classic rock"]},
  {"user_id":"u027","nome":"Clara Monteiro","musicas_escutadas":["Deja Vu","traitor"],"artistas_favoritos":["Olivia Rodrigo"],"generos":["pop"]},
  {"user_id":"u028","nome":"Daniel Correia","musicas_escutadas":["Circles","Rockstar"],"artistas_favoritos":["Post Malone"],"generos":["pop rap","hip hop"]},
  {"user_id":"u029","nome":"Elisa Nobre","musicas_escutadas":["Stay","Ghost"],"artistas_favoritos":["The Kid LAROI","Justin Bieber"],"generos":["pop"]},
  {"user_id":"u030","nome":"Fábio Ventura","musicas_escutadas":["In Da Club","Candy Shop"],"artistas_favoritos":["50 Cent"],"generos":["hip hop","rap"]}
]' AS jsonString

UNWIND apoc.convert.fromJsonList(jsonString) AS row

MERGE (u:Usuario {user_id: row.user_id})
SET u.nome = row.nome

WITH u, row

// Músicas + escutas
UNWIND row.musicas_escutadas AS musica
MERGE (m:Musica {nome: musica})
SET m.image = coalesce(m.image, 'imagens/image.png') // placeholder image; replace per-music if needed
MERGE (u)-[esc:ESCUTOU]->(m)
  SET esc.plays = 8 + toInteger(30 + rand() * 70),
      esc.last_played = datetime() - duration({days: toInteger(rand() * 365)})

WITH u, row

// Artistas + gêneros (em paralelo)
UNWIND row.artistas_favoritos AS artista
MERGE (a:Artista {nome: artista})
SET a.image = coalesce(a.image, 'imagens/image.png') // placeholder image; replace per-artist if needed
MERGE (u)-[:GOSTA_DE {strength: 0.65 + rand()*0.35}]->(a)

WITH u, row, collect(artista) AS artistasCriados

UNWIND row.generos AS genero
MERGE (g:Genero {nome: genero})
MERGE (u)-[:CURTE_GENERO {weight: 0.6 + rand()*0.4}]->(g)

WITH u, row, artistasCriados

// Relacionar músicas aos artistas
UNWIND row.musicas_escutadas AS musicaNome
MATCH (m:Musica {nome: musicaNome})
UNWIND artistasCriados AS artistaNome
MATCH (a:Artista {nome: artistaNome})
MERGE (m)-[:INTERPRETADA_POR]->(a)

//Músicas que pessoas com gostos parecidos escutaram
MATCH (u:Usuario {user_id: "u001"})-[:GOSTA_DE]->(a:Artista)<-[:GOSTA_DE]-(similar:Usuario)
MATCH (similar)-[e:ESCUTOU]->(m:Musica)
WHERE NOT (u)-[:ESCUTOU]->(m)
  AND NOT m.nome IN ["Shape of You", "Blinding Lights", "Levitating"]   // opcional: excluir já conhecidas
WITH m, a, count(DISTINCT similar) AS score
ORDER BY score DESC
RETURN 
  m.nome AS musica,
  collect(DISTINCT a.nome) AS artistas,
  score AS similaridade
LIMIT 10

// Se o relacionamento for GENERO
MATCH (u:Usuario {user_id: "u001"})-[:GOSTA_DE]->(a:Artista)<-[:GOSTA_DE]-(outro:Usuario)
MATCH (outro)-[:ESCUTOU]->(m:Musica)
WHERE NOT (u)-[:ESCUTOU]->(m)
WITH m, collect(DISTINCT a.nome) AS artistas, count(DISTINCT outro) AS score
ORDER BY score DESC
RETURN 
  m.nome AS musica,
  artistas
LIMIT 10

//Artistas semelhantes (filtrando por usuários que gostam dos mesmos artistas)
