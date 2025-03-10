create database desenhos_antigos;
use desenhos_antigos;
show tables;
show databases;
-- Criando a tabela de Estúdios
CREATE TABLE Estudios (
    id_estudio INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    localizacao VARCHAR(255)
);

-- Criando a tabela de Criadores
CREATE TABLE Criadores (
    id_criador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    bio TEXT
);

-- Criando a tabela de Streaming
CREATE TABLE Streaming (
    id_streaming INT PRIMARY KEY AUTO_INCREMENT,
    nome_plataforma VARCHAR(255) NOT NULL,
    link_site VARCHAR(255)
);

-- Criando a tabela de Desenhos
CREATE TABLE Desenhos (
    id_desenho INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    ano_lancamento YEAR,
    descricao TEXT,
    id_estudio INT,
    id_criador INT,
    FOREIGN KEY (id_estudio) REFERENCES Estudios(id_estudio),
    FOREIGN KEY (id_criador) REFERENCES Criadores(id_criador)
);

-- Criando a tabela de Temporadas (agora com nome_desenho)
CREATE TABLE Temporadas (
    id_temporada INT PRIMARY KEY AUTO_INCREMENT,
    id_desenho INT,
    nome_desenho VARCHAR(255) NOT NULL,
    numero_temporada INT,
    ano_inicio YEAR,
    ano_fim YEAR,
    FOREIGN KEY (id_desenho) REFERENCES Desenhos(id_desenho)
);

-- Criando a tabela de Personagens
CREATE TABLE Personagens (
    id_personagem INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    id_desenho INT,
    FOREIGN KEY (id_desenho) REFERENCES Desenhos(id_desenho)
);

-- Criando a tabela de Premiações
CREATE TABLE Premiacoes (
    id_premiacao INT PRIMARY KEY AUTO_INCREMENT,
    id_desenho INT,
    id_criador INT,
    nome_premio VARCHAR(255) NOT NULL,
    ano_premiacao YEAR,
    FOREIGN KEY (id_desenho) REFERENCES Desenhos(id_desenho),
    FOREIGN KEY (id_criador) REFERENCES Criadores(id_criador)
);

-- Criando a tabela intermediária Desenho_Streaming
CREATE TABLE Desenho_Streaming (
    id_desenho INT,
    id_streaming INT,
    PRIMARY KEY (id_desenho, id_streaming),
    FOREIGN KEY (id_desenho) REFERENCES Desenhos(id_desenho),
    FOREIGN KEY (id_streaming) REFERENCES Streaming(id_streaming)
);
-- Inserir dados nos Estúdios
INSERT INTO Estudios (nome, localizacao) VALUES
('Hanna-Barbera', 'Estados Unidos'),
('Disney', 'Estados Unidos'),
('Toei Animation', 'Japão'),
('Warner Bros Animation', 'Estados Unidos'),
('Nickelodeon Animation Studio', 'Estados Unidos');

-- Inserir dados nos Criadores
INSERT INTO Criadores (nome, bio) VALUES
('William Hanna', 'Co-fundador da Hanna-Barbera, criador de diversos desenhos icônicos.'),
('Joseph Barbera', 'Co-fundador da Hanna-Barbera, trabalhou em Tom & Jerry e Os Flintstones.'),
('Walt Disney', 'Fundador da Disney, pioneiro na animação.'),
('Osamu Tezuka', 'Criador de Astro Boy, considerado o pai do mangá moderno.'),
('Chuck Jones', 'Criador de Pernalonga e outros personagens clássicos.');

-- Inserir dados nos Serviços de Streaming
INSERT INTO Streaming (nome_plataforma, link_site) VALUES
('Netflix', 'https://www.netflix.com'),
('Disney+', 'https://www.disneyplus.com'),
('HBO Max', 'https://www.hbomax.com'),
('Prime Video', 'https://www.primevideo.com'),
('Crunchyroll', 'https://www.crunchyroll.com');

-- Inserir dados nos Desenhos
INSERT INTO Desenhos (nome, ano_lancamento, descricao, id_estudio, id_criador) VALUES
('Os Flintstones', 1960, 'Uma família da idade da pedra vivendo aventuras modernas.', 1, 2),
('Tom & Jerry', 1940, 'As aventuras do gato Tom e do rato Jerry.', 1, 2),
('Pernalonga e seus amigos', 1930, 'Uma série de curtas animados com Pernalonga e outros personagens.', 4, 5),
('Astro Boy', 1963, 'Um garoto robô luta pela justiça no futuro.', 3, 4),
('Mickey Mouse', 1928, 'O famoso camundongo da Disney em diversas aventuras.', 2, 3);
select * from temporadas;
-- Inserir dados nas Temporadas
INSERT INTO Temporadas (id_desenho, nome_desenho, numero_temporada, ano_inicio, ano_fim) VALUES
(1, 'Os Flintstones', 1, 1960, 1961),
(1, 'Os Flintstones', 2, 1961, 1962),
(2, 'Tom & Jerry', 1, 1940, 1941),
(3, 'Pernalonga e seus amigos', 1, 1930, 1931),
(4, 'Astro Boy', 1, 1963, 1964),
(5, 'Mickey Mouse', 1, 1928, 1929);

-- Inserir dados nos Personagens
INSERT INTO Personagens (nome, descricao, id_desenho) VALUES
('Fred Flintstone', 'O protagonista de Os Flintstones, um trabalhador das cavernas.', 1),
('Barney Rubble', 'Melhor amigo de Fred Flintstone.', 1),
('Tom', 'O gato caçador de Jerry.', 2),
('Jerry', 'O rato esperto que sempre escapa de Tom.', 2),
('Pernalonga', 'O coelho esperto que vive dizendo "O que é que há, velhinho?".', 3),
('Astro Boy', 'O robô herói que luta contra o mal.', 4),
('Mickey Mouse', 'O famoso camundongo da Disney.', 5);

-- Inserir dados nas Premiações
INSERT INTO Premiacoes (id_desenho, id_criador, nome_premio, ano_premiacao) VALUES
(1, 2, 'Emmy Awards - Melhor Animação', 1961),  -- Os Flintstones (Joseph Barbera)
(2, 2, 'Oscar de Melhor Curta de Animação', 1943),  -- Tom & Jerry (Joseph Barbera)
(3, 5, 'Annie Awards - Contribuição Especial', 1980),  -- Pernalonga e seus amigos (Chuck Jones)
(4, 4, 'Anime Grand Prix - Melhor Série', 1964),  -- Astro Boy (Osamu Tezuka)
(5, 3, 'Academy Awards - Ícone da Animação', 1932);  -- Mickey Mouse (Walt Disney)


-- Inserir dados na relação Desenho ↔ Streaming
INSERT INTO Desenho_Streaming (id_desenho, id_streaming) VALUES
(1, 3),  -- Os Flintstones → HBO Max
(2, 2),  -- Tom & Jerry → Disney+
(3, 3),  -- Pernalonga e seus amigos → HBO Max
(4, 5),  -- Astro Boy → Crunchyroll
(5, 2);  -- Mickey Mouse → Disney+

-- Criar View para visualizar Temporadas com Nome do Desenho
CREATE VIEW View_Temporadas AS
SELECT T.id_temporada, D.nome AS nome_desenho, T.numero_temporada, T.ano_inicio, T.ano_fim
FROM Temporadas T
JOIN Desenhos D ON T.id_desenho = D.id_desenho;

-- Criar View para visualizar Desenhos e Streaming
CREATE VIEW View_Desenhos_Streaming AS
SELECT D.nome AS nome_desenho, S.nome_plataforma
FROM Desenho_Streaming DS
JOIN Desenhos D ON DS.id_desenho = D.id_desenho
JOIN Streaming S ON DS.id_streaming = S.id_streaming;
select * from estudios;
DELETE FROM Estudios WHERE id_estudio = 6;

INSERT INTO Estudios (nome, localizacao) VALUES
('Filmation', 'Estados Unidos'),      -- He-Man e She-Ra
('DIC Entertainment', 'Estados Unidos');  -- Caverna do Dragão

INSERT INTO Criadores (nome, bio) VALUES
('Joe Ruby', 'Co-criador de Scooby-Doo e outros desenhos animados de mistério.'),  -- Scooby-Doo
('Lou Scheimer', 'Criador e produtor de He-Man e She-Ra, ambos cultuados até hoje.'),  -- He-Man, She-Ra
('Hanna-Barbera', 'Criadores de clássicos como Scooby-Doo, Os Jetsons e Os Flintstones.');  -- Scooby-Doo, Os Jetsons
SELECT * FROM Criadores;
INSERT INTO Desenhos (nome, ano_lancamento, descricao, id_estudio, id_criador) VALUES
('Scooby-Doo', 1969, 'Scooby-Doo é um cachorro medroso que, junto com seus amigos, resolve mistérios.', 1, 2),
('He-Man e os Mestres do Universo', 1983, 'He-Man luta contra o vilão Skeletor para salvar o Reino de Eternia.', 2, 2),
('She-Ra', 1985, 'She-Ra, a Princesa do Poder, luta para libertar o reino de Etheria.', 2, 2),
('Caverna do Dragão', 1983, 'Um grupo de jovens fica preso em um mundo fantástico e luta para retornar ao seu lar.', 3, 2),
('Os Jetsons', 1962, 'A família Jetson vive em um futuro tecnológico, com aventuras no espaço e na Terra.', 1, 3),
('ThunderCats', 1985, 'Os ThunderCats são uma raça de felinos alienígenas que lutam contra o mal.', 2, 2),
('Os Smurfs', 1981, 'Pequenos seres azuis que vivem em uma aldeia mágica e enfrentam o mal.', 1, 3),
('O Pequeno Scooby-Doo', 1979, 'Versão infantil de Scooby-Doo com novos mistérios a serem resolvidos.', 1, 2);
SELECT * FROM Desenhos;

INSERT INTO Temporadas (id_desenho, nome_desenho, numero_temporada, ano_inicio, ano_fim) VALUES
(14, 'Scooby-Doo', 1, 1969, 1970),
(15, 'He-Man e os Mestres do Universo', 1, 1983, 1984),
(16, 'She-Ra', 1, 1985, 1986),
(17, 'Caverna do Dragão', 1, 1983, 1984),
(18, 'Os Jetsons', 1, 1962, 1963),
(19, 'ThunderCats', 1, 1985, 1986),
(20, 'Os Smurfs', 1, 1981, 1982),
(21, 'O Pequeno Scooby-Doo', 1, 1979, 1980);

INSERT INTO Personagens (nome, descricao, id_desenho) VALUES
('Scooby-Doo', 'Scooby-Doo é um grande e medroso dogue alemão que adora resolver mistérios com seus amigos.', 14),
('Shaggy', 'Shaggy é o melhor amigo de Scooby-Doo, conhecido por seu apetite e seu medo.', 14),
('Velma', 'Velma é a inteligente da turma, sempre resolvendo os mistérios com lógica.', 14),
('Daphne', 'Daphne é a garota aventureira da turma, sempre se metendo em encrenca.', 14),
('Fred', 'Fred é o líder da turma, sempre organizando as investigações e capturas dos vilões.', 14),
('He-Man', 'He-Man é o príncipe de Eternia e o herói que luta contra o mal, especialmente o vilão Skeletor.', 15),
('Skeletor', 'Skeletor é o principal vilão de He-Man, sempre tentando dominar o castelo de Grayskull.', 15),
('She-Ra', 'She-Ra é a Princesa do Poder, a irmã gêmea de He-Man e líder da resistência contra o Império Horde.', 16),
('Hordak', 'Hordak é o líder do Império Horde e o vilão principal de She-Ra.', 16),
('Dungeons & Dragons', 'Os personagens principais de "Caverna do Dragão" incluem Eric, Diana, Hank, Presto, Sheila, Bobby, e o Mestre dos Magos.', 17),
('George Jetson', 'George Jetson é o patriarca da família Jetson, sempre envolvido em situações futurísticas e engraçadas.', 18),
('Judy Jetson', 'Judy Jetson é a filha adolescente de George, sempre em busca de novas aventuras no futuro.', 18),
('Lion-O', 'Lion-O é o líder dos ThunderCats, um grupo de felinos que luta para defender o planeta de Thundera.', 19),
('Tygra', 'Tygra é o inteligente e habilidoso guerreiro dos ThunderCats, conhecido por sua habilidade com a mente.', 19),
('Papa Smurf', 'Papa Smurf é o líder dos Smurfs, sempre guiando e protegendo os outros Smurfs na aldeia.', 20),
('Smurfette', 'Smurfette é a única Smurf feminina, originalmente criada por Gargamel, mas depois se tornando boa.', 20),
('Pequeno Scooby-Doo', 'Uma versão infantil de Scooby-Doo, ainda mais adorável e travessa.', 21);
select * from criadores;
INSERT INTO Premiacoes (id_desenho, id_criador, nome_premio, ano_premiacao) VALUES
(14, 2, 'Prêmio Emmy - Melhor Programa Infantil', 1970),  -- Scooby-Doo
(15, 7, 'Golden Reel Award - Melhor Som em Animação', 1984),  -- He-Man
(16, 7, 'Annie Awards - Melhor Série de Animação', 1986),  -- She-Ra
(17, 6, 'Prêmio de Melhor Animação Infantil', 1984),  -- Caverna do Dragão
(18, 8, 'Prêmio Hugo - Melhor Série de Animação', 1963),  -- Os Jetsons
(19, 6, 'Golden Globe - Melhor Série de Animação', 1986),  -- ThunderCats
(20, 7, 'Annie Award - Melhor Série de Animação', 1982),  -- Os Smurfs
(21, 8, 'Prêmio Kids’ Choice Awards - Melhor Desenho Animado', 1980);  -- O Pequeno Scooby-Doo
INSERT INTO Desenho_Streaming (id_desenho, id_streaming) VALUES
(14, 2),  -- Scooby-Doo → Disney+
(15, 4),  -- He-Man → Prime Video
(16, 4),  -- She-Ra → Prime Video
(17, 3),  -- Caverna do Dragão → HBO Max
(18, 2),  -- Os Jetsons → Disney+
(19, 5),  -- ThunderCats → Crunchyroll
(20, 2),  -- Os Smurfs → Disney+
(21, 2);  -- O Pequeno Scooby-Doo → Disney+
