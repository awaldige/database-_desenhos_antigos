create database desenhos_antigos;
use desenhos_antigos;
show databases;
show tables;
SELECT COUNT(*) AS total_tabelas 
FROM information_schema.tables 
WHERE table_schema = 'desenhos_antigos';

-- Criando a tabela desenhos
CREATE TABLE desenhos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    ano_criacao INT NOT NULL,
    pais_origem VARCHAR(100) NOT NULL,
    classificacao VARCHAR(20) NOT NULL,
    sinopse TEXT,
    genero VARCHAR(100)
);

-- Criando a tabela criadores
CREATE TABLE criadores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    nacionalidade VARCHAR(50),
    principais_trabalhos TEXT
);

-- Criando a tabela intermediária para associar criadores a desenhos (N:N)
CREATE TABLE desenho_criador (
    id SERIAL PRIMARY KEY,
    desenho_id INT REFERENCES desenhos(id) ON DELETE CASCADE,
    criador_id INT REFERENCES criadores(id) ON DELETE CASCADE
);

-- Criando a tabela temporadas
CREATE TABLE temporadas (
    id SERIAL PRIMARY KEY,
    desenho_id INT REFERENCES desenhos(id) ON DELETE CASCADE,
    numero_temporada INT NOT NULL,
    ano_lancamento INT NOT NULL,
    total_episodios INT NOT NULL
);
select *from episodios;
-- Criando a tabela episodios
CREATE TABLE episodios (
    id SERIAL PRIMARY KEY,
    temporada_id INT REFERENCES temporadas(id) ON DELETE CASCADE,
    numero INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    data_exibicao DATE,
    duracao_min INT
);

-- Criando a tabela personagens
CREATE TABLE personagens (
    id SERIAL PRIMARY KEY,
    desenho_id INT REFERENCES desenhos(id) ON DELETE CASCADE,
    nome VARCHAR(255) NOT NULL,
    papel VARCHAR(100), -- Protagonista, Vilão, Secundário
    dublador_original VARCHAR(255),
    descricao TEXT
);

-- Criando a tabela estudios
CREATE TABLE estudios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    pais VARCHAR(100)
);

-- Criando a tabela intermediária entre desenhos e estúdios (N:N)
CREATE TABLE desenho_estudio (
    id SERIAL PRIMARY KEY,
    desenho_id INT REFERENCES desenhos(id) ON DELETE CASCADE,
    estudio_id INT REFERENCES estudios(id) ON DELETE CASCADE
);

-- Criando a tabela de premiações
CREATE TABLE premiacoes (
    id SERIAL PRIMARY KEY,
    desenho_id INT REFERENCES desenhos(id) ON DELETE CASCADE,
    nome_premio VARCHAR(255) NOT NULL,
    ano INT NOT NULL,
    categoria VARCHAR(255)
);

-- Criando a tabela streaming
CREATE TABLE streaming (
    id SERIAL PRIMARY KEY,
    desenho_id INT REFERENCES desenhos(id) ON DELETE CASCADE,
    plataforma VARCHAR(100) NOT NULL,
    link VARCHAR(500)
);

-- inserindo desenhos
INSERT INTO desenhos (nome, ano_criacao, pais_origem, classificacao, sinopse, genero) VALUES
('Scooby-Doo, Where Are You!', 1969, 'EUA', 'Livre', 'Um grupo de adolescentes e seu cachorro solucionam mistérios sobrenaturais.', 'Mistério, Aventura'),
('Os Flintstones', 1960, 'EUA', 'Livre', 'Acompanhe a vida da família Flintstone na Idade da Pedra.', 'Comédia, Família'),
('Os Jetsons', 1962, 'EUA', 'Livre', 'Uma família futurista vivendo em uma sociedade avançada tecnologicamente.', 'Comédia, Ficção Científica'),
('Speed Racer', 1967, 'Japão', 'Livre', 'As aventuras do piloto de corridas Speed Racer e seu icônico Mach 5.', 'Ação, Esportes'),
('He-Man e os Mestres do Universo', 1983, 'EUA', 'Livre', 'O príncipe Adam se transforma em He-Man para defender Eternia das forças do mal.', 'Ação, Fantasia'),
('She-Ra: A Princesa do Poder', 1985, 'EUA', 'Livre', 'A irmã de He-Man, Adora, lidera a resistência contra o tirano Hordak.', 'Ação, Fantasia'),
('Thundercats', 1985, 'EUA', 'Livre', 'Os Thundercats fogem de seu planeta destruído e enfrentam novos desafios na Terceira Terra.', 'Ação, Ficção Científica'),
('Caverna do Dragão', 1983, 'EUA', 'Livre', 'Crianças são transportadas para um mundo mágico e lutam para voltar para casa.', 'Fantasia, Aventura'),
('Transformers', 1984, 'EUA/Japão', 'Livre', 'Os Autobots lutam contra os Decepticons em uma guerra intergaláctica.', 'Ação, Ficção Científica'),
('Comandos em Ação (G.I. Joe)', 1983, 'EUA', 'Livre', 'Forças especiais militares lutam contra a organização Cobra.', 'Ação, Militar'),
('DuckTales: Os Caçadores de Aventuras', 1987, 'EUA', 'Livre', 'Tio Patinhas e seus sobrinhos embarcam em aventuras para encontrar tesouros.', 'Aventura, Comédia'),
('Muppet Babies', 1984, 'EUA', 'Livre', 'Os Muppets em suas versões infantis vivem grandes aventuras na creche.', 'Infantil, Comédia'),
('O Pequeno Scooby-Doo', 1988, 'EUA', 'Livre', 'Scooby-Doo e seus amigos investigam mistérios quando crianças.', 'Mistério, Infantil'),
('Tarzan, O Rei das Selvas', 1976, 'EUA', 'Livre', 'As aventuras do herói Tarzan na selva lutando contra caçadores e perigos.', 'Aventura, Ação'),
('Space Ghost', 1966, 'EUA', 'Livre', 'Um super-herói espacial e seus ajudantes enfrentam vilões intergalácticos.', 'Ação, Ficção Científica'),
('Os Smurfs', 1981, 'Bélgica/EUA', 'Livre', 'Pequenas criaturas azuis vivem em uma aldeia mágica e enfrentam o vilão Gargamel.', 'Fantasia, Comédia'),
('Doug', 1991, 'EUA', 'Livre', 'Doug Funnie enfrenta os desafios da adolescência com criatividade e imaginação.', 'Slice of Life, Comédia'),
('Rambo: A Força da Liberdade', 1986, 'EUA', '10+', 'Rambo lidera um grupo de operações especiais contra o General Warhawk.', 'Ação, Militar'),
('Capitão Planeta e os Protetores', 1990, 'EUA', 'Livre', 'Jovens com anéis elementares invocam o Capitão Planeta para proteger o meio ambiente.', 'Aventura, Educação'),
('X-Men: A Série Animada', 1992, 'EUA', 'Livre', 'Os mutantes X-Men lutam contra vilões e tentam coexistir com os humanos.', 'Ação, Super-heróis');

-- inserindo  criadores
INSERT INTO criadores (nome, nacionalidade, principais_trabalhos) VALUES
('Hanna-Barbera', 'EUA', 'Scooby-Doo, Os Flintstones, Os Jetsons, Space Ghost'),
('Osamu Tezuka', 'Japão', 'Astro Boy, Kimba, o Leão Branco'),
('Shigeru Miyamoto', 'Japão', 'Super Mario Bros: A Série, The Legend of Zelda'),
('Stan Lee', 'EUA', 'X-Men: A Série Animada, O Incrível Hulk, Homem-Aranha'),
('Bruce Timm', 'EUA', 'Batman: A Série Animada, Liga da Justiça, Superman: A Série Animada'),
('Jean Chalopin', 'França', 'Caverna do Dragão, Pole Position, Inspetor Bugiganga'),
('Jim Henson', 'EUA', 'Muppet Babies'),
('Ted Wolf', 'EUA', 'Thundercats'),
('Lou Scheimer', 'EUA', 'He-Man e os Mestres do Universo, She-Ra: A Princesa do Poder'),
('Yoshiyuki Tomino', 'Japão', 'Mobile Suit Gundam'),
('Joe Ruby', 'EUA', 'Scooby-Doo, Dino Boy, Jabberjaw'),
('Ken Spears', 'EUA', 'Scooby-Doo, Speed Buggy, Capitão Caverna'),
('Bob Kane', 'EUA', 'Batman: A Série Animada'),
('Kevin Eastman', 'EUA', 'As Tartarugas Ninja'),
('Peter Laird', 'EUA', 'As Tartarugas Ninja'),
('Michael Hirsh', 'Canadá', 'Os Smurfs, Care Bears'),
('Sunbow Productions', 'EUA', 'Transformers, Comandos em Ação (G.I. Joe)'),
('Ron Friedman', 'EUA', 'Transformers: The Movie, Comandos em Ação (G.I. Joe)'),
('Doug Wildey', 'EUA', 'Jonny Quest'),
('John Kricfalusi', 'Canadá', 'The Ren & Stimpy Show');

ALTER TABLE temporadas ADD COLUMN numero INT;
-- iserindo temporadas
INSERT INTO temporadas (desenho_id, numero, numero_temporada, ano_lancamento, total_episodios) VALUES
(1, 1, 1, 1976, 26),
(1, 2, 2, 1977, 24),
(2, 3, 1, 1981, 22),
(2, 4, 2, 1982, 20),
(3, 5, 1, 1985, 25),
(3, 6, 2, 1986, 21),
(4, 7, 1, 1984, 18),
(4, 8, 2, 1985, 23),
(5, 9, 1, 1990, 30),
(5, 10, 2, 1991, 28),
(6, 11, 1, 1983, 22),
(6, 12, 2, 1984, 26),
(7, 13, 1, 1978, 20),
(7, 14, 2, 1979, 22),
(8, 15, 1, 1995, 32),
(8, 16, 2, 1996, 30),
(9, 17, 1, 1988, 24),
(9, 18, 2, 1989, 22),
(10, 19, 1, 1992, 26),
(10, 20, 2, 1993, 28);

-- iserindo episodios
INSERT INTO episodios (temporada_id, numero, titulo, data_exibicao) VALUES
(1, 1, 'A Aventura Começa', '1976-01-05'),
(1, 2, 'O Mistério do Castelo', '1976-01-12'),
(1, 3, 'Corrida Contra o Tempo', '1976-01-19'),
(1, 4, 'O Inimigo Invisível', '1976-01-26'),
(2, 1, 'O Retorno do Vilão', '1977-02-10'),
(2, 2, 'Uma Jornada Perigosa', '1977-02-17'),
(2, 3, 'Aliens Entre Nós', '1977-02-24'),
(2, 4, 'A Armadilha Mortal', '1977-03-03'),
(3, 1, 'O Grande Torneio', '1981-05-10'),
(3, 2, 'O Segredo do Amuleto', '1981-05-17'),
(3, 3, 'Fuga da Ilha Proibida', '1981-05-24'),
(3, 4, 'A Última Esperança', '1981-05-31'),
(4, 1, 'O Portal Mágico', '1982-06-15'),
(4, 2, 'Encontro com o Destino', '1982-06-22'),
(4, 3, 'Uma Nova Ameaça', '1982-06-29'),
(4, 4, 'A Espada Lendária', '1982-07-06'),
(5, 1, 'Sombras do Passado', '1985-09-10'),
(5, 2, 'O Desafio Supremo', '1985-09-17'),
(5, 3, 'A Cidade Submersa', '1985-09-24'),
(5, 4, 'O Fim ou um Novo Começo?', '1985-10-01');

-- inserindo personagens
INSERT INTO personagens (nome, desenho_id, descricao) VALUES
('Scooby-Doo', 1, 'Um cão detetive medroso que ama biscoitos Scooby.'),
('Salsicha Rogers', 1, 'Melhor amigo de Scooby, sempre faminto e medroso.'),
('Fred Jones', 1, 'Líder do Mistério S/A, criador das armadilhas.'),
('Daphne Blake', 1, 'Investigadora do grupo Mistério S/A, corajosa e elegante.'),
('Velma Dinkley', 1, 'Gênio do grupo Mistério S/A, resolve mistérios com sua inteligência.'),
('Kermit, o Sapo', 2, 'Líder dos Muppets, um sapo otimista e carismático.'),
('Miss Piggy', 2, 'Diva dos Muppets, determinada e apaixonada por Kermit.'),
('Fozzie Bear', 2, 'Urso comediante dos Muppets, famoso por suas piadas ruins.'),
('Baby Kermit', 3, 'Versão bebê de Kermit, curioso e sonhador.'),
('Baby Miss Piggy', 3, 'Versão bebê de Miss Piggy, com personalidade forte.'),
('Rambo', 4, 'Soldado de elite, especialista em combate e sobrevivência.'),
('Duke', 5, 'Líder do G.I. Joe, estrategista e corajoso.'),
('Cobra Commander', 5, 'Vilão do G.I. Joe, líder da organização Cobra.'),
('Optimus Prime', 6, 'Líder dos Autobots, defensor da justiça e liberdade.'),
('Megatron', 6, 'Líder dos Decepticons, deseja conquistar o universo.'),
('Tarzan', 7, 'Homem criado na selva, ágil e forte, comunicando-se com animais.'),
('Jane Porter', 7, 'Exploradora e interesse romântico de Tarzan.'),
('Space Ghost', 8, 'Herói intergaláctico que combate vilões com seus braceletes energéticos.'),
('Zorak', 8, 'Vilão e inimigo de Space Ghost, um louva-a-deus maligno.'),
('Brak', 8, 'Vilão secundário de Space Ghost, conhecido por seu jeito cômico.');

-- inserindo estudios
INSERT INTO estudios (nome, pais) VALUES
('Walt Disney Animation Studios', 'EUA'),
('Warner Bros. Animation', 'EUA'),
('Hanna-Barbera', 'EUA'),
('Pixar Animation Studios', 'EUA'),
('DreamWorks Animation', 'EUA'),
('Nickelodeon Animation Studio', 'EUA'),
('Sony Pictures Animation', 'EUA'),
('Cartoon Network Studios', 'EUA'),
('Blue Sky Studios', 'EUA'),
('Illumination Entertainment', 'EUA'),
('Toei Animation', 'Japão'),
('Studio Ghibli', 'Japão'),
('Kyoto Animation', 'Japão'),
('Madhouse', 'Japão'),
('Sunrise', 'Japão'),
('Bones', 'Japão'),
('MAPPA', 'Japão'),
('Gainax', 'Japão'),
('Production I.G', 'Japão'),
('Aardman Animations', 'Reino Unido');

-- inserir dados desenhos_studio 
iNSERT INTO desenho_estudio (desenho_id, estudio_id) VALUES
(1, 3),  -- Scooby-Doo → Hanna-Barbera
(2, 11), -- Astro Boy → Toei Animation
(3, 12), -- Super Mario → Studio Ghibli (Exemplo, pode não ser o correto)
(4, 2),  -- X-Men → Warner Bros. Animation
(5, 2),  -- Batman: A Série Animada → Warner Bros. Animation
(6, 6),  -- Caverna do Dragão → Nickelodeon Animation Studio (Exemplo)
(7, 5),  -- Muppet Babies → DreamWorks Animation
(8, 3),  -- Thundercats → Hanna-Barbera
(9, 3),  -- He-Man → Hanna-Barbera
(10, 14), -- Mobile Suit Gundam → Sunrise
(11, 3),  -- Dino Boy → Hanna-Barbera
(12, 3),  -- Speed Buggy → Hanna-Barbera
(13, 2),  -- Batman → Warner Bros. Animation
(14, 7),  -- Tartarugas Ninja → Sony Pictures Animation
(15, 7),  -- Tartarugas Ninja → Sony Pictures Animation
(16, 9),  -- Smurfs → Blue Sky Studios
(17, 8),  -- Transformers → Cartoon Network Studios
(18, 8),  -- G.I. Joe → Cartoon Network Studios
(19, 3),  -- Jonny Quest → Hanna-Barbera
(20, 10); -- The Ren & Stimpy Show → Illumination Entertainment (Exemplo)

-- adicionar  dados premiações
INSERT INTO premiacoes (desenho_id, nome_premio, ano, categoria) VALUES
(1, 'Emmy Award', 1970, 'Melhor Programa Infantil'),
(1, 'Annie Award', 2003, 'Melhor Série Animada'),
(2, 'Tokyo Anime Award', 2004, 'Melhor Animação Clássica'),
(3, 'Oscar', 1989, 'Melhor Curta de Animação'),
(4, 'Golden Globe', 1995, 'Melhor Filme de Animação'),
(5, 'Annie Award', 1992, 'Melhor Direção em Animação'),
(6, 'BAFTA Children’s Award', 1987, 'Melhor Animação Infantil'),
(7, 'Primetime Emmy', 1999, 'Melhor Série Animada'),
(8, 'Academy Award', 1994, 'Melhor Trilha Sonora'),
(9, 'Kids’ Choice Award', 2005, 'Programa de TV Favorito'),
(10, 'Emmy Award', 2007, 'Melhor Roteiro para Série Animada'),
(11, 'Golden Reel Award', 2002, 'Melhor Edição de Som'),
(12, 'People’s Choice Award', 2010, 'Desenho Mais Popular'),
(13, 'Saturn Award', 1997, 'Melhor Animação de Ficção Científica'),
(14, 'Annie Award', 2015, 'Melhor Série de Animação para TV'),
(15, 'Oscar', 2018, 'Melhor Filme de Animação'),
(16, 'Golden Globe', 2020, 'Melhor Filme Animado'),
(17, 'Critics’ Choice Award', 2019, 'Melhor Animação para Crianças'),
(18, 'Emmy Award', 2021, 'Melhor Série Animada Infantil'),
(19, 'BAFTA Award', 2003, 'Melhor Animação Britânica');

select * from streaming ;
-- inserindo dados streaming 
INSERT INTO streaming (desenho_id, plataforma, link) VALUES
(1, 'Netflix', 'https://www.netflix.com'),
(2, 'Amazon Prime Video', 'https://www.primevideo.com'),
(3, 'Disney+', 'https://www.disneyplus.com'),
(4, 'HBO Max', 'https://www.hbomax.com'),
(5, 'Hulu', 'https://www.hulu.com'),
(6, 'Apple TV+', 'https://tv.apple.com'),
(7, 'Paramount+', 'https://www.paramountplus.com'),
(8, 'Peacock', 'https://www.peacocktv.com'),
(9, 'Crunchyroll', 'https://www.crunchyroll.com'),
(10, 'Funimation', 'https://www.funimation.com'),
(11, 'Rakuten Viki', 'https://www.viki.com'),
(12, 'Globo Play', 'https://globoplay.globo.com'),
(13, 'Star+', 'https://www.starplus.com'),
(14, 'Discovery+', 'https://www.discoveryplus.com'),
(15, 'YouTube Premium', 'https://www.youtube.com/premium'),
(16, 'Now', 'https://www.nowonline.com.br'),
(17, 'Pluto TV', 'https://www.pluto.tv'),
(18, 'BBC iPlayer', 'https://www.bbc.co.uk/iplayer'),
(19, 'Tubi', 'https://tubitv.com'),
(20, 'Amazon Freevee', 'https://www.amazon.com/freevee');
