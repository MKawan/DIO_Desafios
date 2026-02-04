// 1. Constraints de unicidade (já criam índices automáticos para as propriedades)
CREATE CONSTRAINT user_username_unique IF NOT EXISTS
FOR (u:User) REQUIRE u.username IS UNIQUE;

CREATE CONSTRAINT user_id_unique IF NOT EXISTS
FOR (u:User) REQUIRE u.user_id IS UNIQUE;

// 2. Índices adicionais úteis
// Para buscas rápidas por location
CREATE INDEX user_location_idx IF NOT EXISTS
FOR (u:User) ON (u.location);

// Para buscas por idade (se for comum filtrar por faixa etária)
CREATE INDEX user_age_idx IF NOT EXISTS
FOR (u:User) ON (u.age);

// Nota: Não crie índice simples em interests (array)
// Se quiser buscar por interesses específicos, considere:
// - full-text index (Neo4j 5.x+) ou
// - manter como está e usar predicado IN
// CREATE FULLTEXT INDEX user_interests_fulltext IF NOT EXISTS
// FOR (u:User) ON EACH [u.interests] OPTIONS {indexConfig: {`fulltext.analyzer`: 'standard'}};

// 3. Criação dos usuários (UNWIND com mapa correto - sem aspas nas chaves)
UNWIND [
    {user_id: 1, username: "user1", full_name: "Alice Johnson",   age: 28, location: "New York",       interests: ["reading", "traveling", "coding"]},
    {user_id: 2, username: "user2", full_name: "Bob Smith",       age: 32, location: "Los Angeles",    interests: ["sports", "music", "gaming"]},
    {user_id: 3, username: "user3", full_name: "Charlie Davis",   age: 25, location: "Chicago",        interests: ["art", "cooking", "hiking"]},
    {user_id: 4, username: "user4", full_name: "Dana Evans",      age: 30, location: "Miami",          interests: ["photography", "yoga", "reading"]},
    {user_id: 5, username: "user5", full_name: "Evan Foster",     age: 27, location: "Seattle",        interests: ["coding", "gaming", "traveling"]},
    {user_id: 6, username: "user6", full_name: "Fiona Green",     age: 29, location: "Boston",         interests: ["music", "art", "sports"]},
    {user_id: 7, username: "user7", full_name: "George Harris",   age: 31, location: "Denver",         interests: ["hiking", "cooking", "photography"]},
    {user_id: 8, username: "user8", full_name: "Hannah Irving",   age: 26, location: "Austin",         interests: ["yoga", "reading", "music"]},
    {user_id: 9, username: "user9", full_name: "Ian Jackson",     age: 33, location: "Portland",       interests: ["gaming", "traveling", "art"]},
    {user_id: 10, username: "user10", full_name: "Jenna King",    age: 24, location: "San Francisco",  interests: ["coding", "sports", "hiking"]},
    {user_id: 11, username: "user11", full_name: "Kevin Lee",     age: 35, location: "New York",       interests: ["cooking", "photography", "yoga"]},
    {user_id: 12, username: "user12", full_name: "Laura Miller",  age: 28, location: "Los Angeles",    interests: ["reading", "music", "gaming"]},
    {user_id: 13, username: "user13", full_name: "Mike Nelson",   age: 30, location: "Chicago",        interests: ["traveling", "art", "sports"]},
    {user_id: 14, username: "user14", full_name: "Nina Owens",    age: 27, location: "Miami",          interests: ["hiking", "coding", "cooking"]},
    {user_id: 15, username: "user15", full_name: "Oscar Patel",   age: 29, location: "Seattle",        interests: ["photography", "yoga", "reading"]},
    {user_id: 16, username: "user16", full_name: "Paula Quinn",   age: 31, location: "Boston",         interests: ["music", "gaming", "traveling"]},
    {user_id: 17, username: "user17", full_name: "Quinn Roberts", age: 26, location: "Denver",         interests: ["art", "sports", "hiking"]},
    {user_id: 18, username: "user18", full_name: "Rachel Scott",  age: 32, location: "Austin",         interests: ["cooking", "photography", "coding"]},
    {user_id: 19, username: "user19", full_name: "Sam Taylor",    age: 25, location: "Portland",       interests: ["yoga", "reading", "music"]},
    {user_id: 20, username: "user20", full_name: "Tina Underwood",age: 34, location: "San Francisco",  interests: ["gaming", "traveling", "art"]},
    {user_id: 21, username: "user21", full_name: "Uma Vance",     age: 28, location: "New York",       interests: ["sports", "hiking", "cooking"]},
    {user_id: 22, username: "user22", full_name: "Victor White",  age: 30, location: "Los Angeles",    interests: ["photography", "yoga", "gaming"]},
    {user_id: 23, username: "user23", full_name: "Wendy Xu",      age: 27, location: "Chicago",        interests: ["reading", "music", "traveling"]},
    {user_id: 24, username: "user24", full_name: "Xander Young",  age: 29, location: "Miami",          interests: ["art", "sports", "coding"]},
    {user_id: 25, username: "user25", full_name: "Yara Zimmerman",age: 31, location: "Seattle",        interests: ["hiking", "cooking", "photography"]},
    {user_id: 26, username: "user26", full_name: "Zack Adams",    age: 26, location: "Boston",         interests: ["yoga", "reading", "music"]},
    {user_id: 27, username: "user27", full_name: "Amy Baker",     age: 33, location: "Denver",         interests: ["gaming", "traveling", "art"]},
    {user_id: 28, username: "user28", full_name: "Brian Carter",  age: 24, location: "Austin",         interests: ["sports", "hiking", "cooking"]},
    {user_id: 29, username: "user29", full_name: "Cara Diaz",     age: 35, location: "Portland",       interests: ["photography", "yoga", "reading"]},
    {user_id: 30, username: "user30", full_name: "David Ellis",   age: 28, location: "San Francisco",  interests: ["music", "gaming", "traveling"]}
] AS userData
CREATE (:User {
    user_id:   userData.user_id,
    username:  userData.username,
    full_name: userData.full_name,
    age:       userData.age,
    location:  userData.location,
    interests: userData.interests
});

// 4. Criação de relacionamentos de amizade (exemplos manuais + automação)
MATCH (u1:User {user_id: 1}), (u5:User {user_id: 5})
CREATE (u1)-[:FRIENDS_WITH {since: timestamp()}]->(u5)
      ,(u5)-[:FRIENDS_WITH {since: timestamp()}]->(u1);   // bidirecional

MATCH (u2:User {user_id: 2}), (u6:User {user_id: 6})
CREATE (u2)-[:FRIENDS_WITH {since: timestamp()}]->(u6)
      ,(u6)-[:FRIENDS_WITH {since: timestamp()}]->(u2);

//5. Consultas de Busca e Análise de Sugestões de Amizades

// - Busca Simples por Username:

MATCH (u:User {username: 'user1'})
RETURN u;

// - Busca por Localização e Interesses:

MATCH (u:User)
WHERE u.location = 'New York' AND 'reading' IN u.interests
RETURN u;

// - Sugestões de Amizades Baseadas em Amigos em Comum (Grau 2: Amigos de Amigos):

MATCH (u:User {user_id: 1})-[*2]-(potential:User)
WHERE NOT (u)-[:FRIENDS_WITH]-(potential) AND u <> potential
WITH potential, count(*) AS commonFriends
RETURN potential.username, commonFriends
ORDER BY commonFriends DESC
LIMIT 5;

// -  Sugestões Baseadas em Interesses Compartilhados:

MATCH (u:User {user_id: 1})
WITH u, u.interests AS meusInteresses

MATCH (potencial:User)
WHERE potencial.user_id <> u.user_id

OPTIONAL MATCH (u)-[f:FRIENDS_WITH]-(potencial)
WITH u, potencial, meusInteresses, f
WHERE f IS NULL   // só não-amigos

WITH potencial,
     size(apoc.coll.intersection(meusInteresses, potencial.interests)) AS interessesEmComum

RETURN 
    potencial.username AS sugerido,
    potencial.full_name AS nome_completo,
    potencial.location AS localizacao,
    interessesEmComum,
    CASE WHEN interessesEmComum >= 2 THEN "Boa sugestão" 
         WHEN interessesEmComum = 1 THEN "Interesse parcial"
         ELSE "Baixa afinidade" END AS nivel_afinidade
ORDER BY interessesEmComum DESC, potencial.username
LIMIT 10;