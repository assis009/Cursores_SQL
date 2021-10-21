CREATE DATABASE atividade_cursores

GO

USE atividade_cursores

GO

CREATE TABLE curso(

codigo		INT NOT NULL,
nome		VARCHAR(150)NULL,
duracao		INT NOT NULL

PRIMARY KEY(codigo)

)

GO 

CREATE TABLE disciplina(

codigo		INT NOT NULL,
nome		VARCHAR(150)NULL,
carga_horaria		INT NOT NULL

PRIMARY KEY(codigo)

)

GO

CREATE TABLE disciplina_curso(

codigo_disciplina		INT NOT NULL,
codigo_curso			INT NOT NULL,

FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
FOREIGN KEY (codigo_curso) REFERENCES curso(codigo),
PRIMARY KEY(codigo_disciplina,codigo_curso)

)

GO

INSERT INTO curso VALUES
(0, 'Análise e Desenvolvimento de Sistemas', 2880),
(1, 'Logistica', 2880),
(2, 'Polímeros', 2880),
(3, 'Comércio Exterior', 2600),
(4, 'Gestão Empresarial', 2600)


GO 

INSERT INTO disciplina VALUES 
(1, 'Algoritmos', 80),
(2, 'Administração', 80),
(3, 'Laboratório de Hardware', 40),
(4, 'Pesquisa Operacional', 80),
(5, 'Física I', 80),
(6, 'Físico Química', 80),
(7, 'Comércio Exterior', 80),
(8, 'Fundamentos de Marketing', 80),
(9, 'Informática', 40),
(10, 'Sistemas de Informação', 80)

GO 

INSERT INTO disciplina_curso VALUES
(1,0),
(2,0),
(2,1),
(2,3),
(2,4),
(3,0),
(4,1),
(5,2),
(6,2),
(7,1),
(7,3),
(8,1),
(8,4),
(9,1),
(9,3),
(10,0),
(10,4)


CREATE FUNCTION fn_lista_disciplina_cursos( @codigo INT)
RETURNS @tabela TABLE(
nome_disciplina			VARCHAR(150),
carga_horaria			INT,
nome_curso				VARCHAR(150)
)
AS
BEGIN
	DECLARE
			@nome_disciplina	VARCHAR(150),
			@carga_horaria		INT,
			@nome_curso			VARCHAR(150)
	DECLARE cur CURSOR FOR
		SELECT d.nome, d.carga_horaria, c.nome
		FROM disciplina d, curso c, disciplina_curso dc
		WHERE d.codigo = dc.codigo_disciplina
			AND c.codigo = dc.codigo_curso
			AND c.codigo = @codigo
 
	OPEN cur
	FETCH NEXT FROM cur INTO @nome_disciplina, @carga_horaria,@nome_curso
	WHILE @@FETCH_STATUS = 0
	BEGIN
			INSERT INTO @tabela VALUES
			(@nome_disciplina, @carga_horaria, @nome_curso)
 
		FETCH NEXT FROM cur INTO @nome_disciplina, @carga_horaria,@nome_curso
	END
 
	CLOSE cur
	DEALLOCATE cur
 
	RETURN
END


 
SELECT * FROM fn_lista_disciplina_cursos(0)