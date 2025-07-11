USE [master]
GO
/****** Object:  Database [Estudiantes]    Script Date: 14/05/2025 7:59:53 p. m. ******/
CREATE DATABASE [Estudiantes]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Estudiantes', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\Estudiantes.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Estudiantes_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\Estudiantes_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Estudiantes] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Estudiantes].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Estudiantes] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Estudiantes] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Estudiantes] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Estudiantes] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Estudiantes] SET ARITHABORT OFF 
GO
ALTER DATABASE [Estudiantes] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Estudiantes] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Estudiantes] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Estudiantes] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Estudiantes] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Estudiantes] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Estudiantes] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Estudiantes] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Estudiantes] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Estudiantes] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Estudiantes] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Estudiantes] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Estudiantes] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Estudiantes] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Estudiantes] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Estudiantes] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Estudiantes] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Estudiantes] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Estudiantes] SET  MULTI_USER 
GO
ALTER DATABASE [Estudiantes] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Estudiantes] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Estudiantes] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Estudiantes] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Estudiantes] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Estudiantes] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Estudiantes] SET QUERY_STORE = ON
GO
ALTER DATABASE [Estudiantes] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Estudiantes]
GO
/****** Object:  Table [dbo].[Credito]    Script Date: 14/05/2025 7:59:53 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Credito](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TotalCredito] [numeric](18, 2) NULL,
 CONSTRAINT [PK_Credito] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estudiante]    Script Date: 14/05/2025 7:59:53 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estudiante](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[CreditoId] [int] NOT NULL,
 CONSTRAINT [PK_Estudiante] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstudianteMateria]    Script Date: 14/05/2025 7:59:53 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstudianteMateria](
	[EstudianteId] [int] NOT NULL,
	[MateriaId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EstudianteId] ASC,
	[MateriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Materia]    Script Date: 14/05/2025 7:59:53 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materia](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ProfesorId] [int] NULL,
 CONSTRAINT [PK_Materia] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profesor]    Script Date: 14/05/2025 7:59:53 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profesor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Profesor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Credito] ON 

INSERT [dbo].[Credito] ([Id], [TotalCredito]) VALUES (1, CAST(3.00 AS Numeric(18, 2)))
SET IDENTITY_INSERT [dbo].[Credito] OFF
GO
SET IDENTITY_INSERT [dbo].[Estudiante] ON 

INSERT [dbo].[Estudiante] ([Id], [Nombre], [CreditoId]) VALUES (13, N'Emilse', 1)
INSERT [dbo].[Estudiante] ([Id], [Nombre], [CreditoId]) VALUES (14, N'edgar', 1)
INSERT [dbo].[Estudiante] ([Id], [Nombre], [CreditoId]) VALUES (15, N'ana', 1)
INSERT [dbo].[Estudiante] ([Id], [Nombre], [CreditoId]) VALUES (16, N'maria', 1)
INSERT [dbo].[Estudiante] ([Id], [Nombre], [CreditoId]) VALUES (17, N'Felipe', 1)
INSERT [dbo].[Estudiante] ([Id], [Nombre], [CreditoId]) VALUES (18, N'Derly', 1)
INSERT [dbo].[Estudiante] ([Id], [Nombre], [CreditoId]) VALUES (19, N'Derlyw', 1)
SET IDENTITY_INSERT [dbo].[Estudiante] OFF
GO
INSERT [dbo].[EstudianteMateria] ([EstudianteId], [MateriaId]) VALUES (13, 3)
INSERT [dbo].[EstudianteMateria] ([EstudianteId], [MateriaId]) VALUES (14, 3)
INSERT [dbo].[EstudianteMateria] ([EstudianteId], [MateriaId]) VALUES (15, 3)
INSERT [dbo].[EstudianteMateria] ([EstudianteId], [MateriaId]) VALUES (16, 3)
INSERT [dbo].[EstudianteMateria] ([EstudianteId], [MateriaId]) VALUES (17, 4)
INSERT [dbo].[EstudianteMateria] ([EstudianteId], [MateriaId]) VALUES (18, 4)
INSERT [dbo].[EstudianteMateria] ([EstudianteId], [MateriaId]) VALUES (19, 3)
INSERT [dbo].[EstudianteMateria] ([EstudianteId], [MateriaId]) VALUES (19, 13)
GO
SET IDENTITY_INSERT [dbo].[Materia] ON 

INSERT [dbo].[Materia] ([id], [Nombre], [ProfesorId]) VALUES (3, N'Matematicas', 2)
INSERT [dbo].[Materia] ([id], [Nombre], [ProfesorId]) VALUES (4, N'Español', 2)
INSERT [dbo].[Materia] ([id], [Nombre], [ProfesorId]) VALUES (5, N'Sociales', 1)
INSERT [dbo].[Materia] ([id], [Nombre], [ProfesorId]) VALUES (6, N'Geografia', 1)
INSERT [dbo].[Materia] ([id], [Nombre], [ProfesorId]) VALUES (7, N'Biologia', 4)
INSERT [dbo].[Materia] ([id], [Nombre], [ProfesorId]) VALUES (8, N'Ciencias', 4)
INSERT [dbo].[Materia] ([id], [Nombre], [ProfesorId]) VALUES (9, N'Historia', 5)
INSERT [dbo].[Materia] ([id], [Nombre], [ProfesorId]) VALUES (10, N'Fisica', 5)
INSERT [dbo].[Materia] ([id], [Nombre], [ProfesorId]) VALUES (12, N'Trigonometria', 6)
INSERT [dbo].[Materia] ([id], [Nombre], [ProfesorId]) VALUES (13, N'Filosofia', 7)
SET IDENTITY_INSERT [dbo].[Materia] OFF
GO
SET IDENTITY_INSERT [dbo].[Profesor] ON 

INSERT [dbo].[Profesor] ([Id], [Nombre]) VALUES (1, N'Profesor A')
INSERT [dbo].[Profesor] ([Id], [Nombre]) VALUES (2, N'Profesor B')
INSERT [dbo].[Profesor] ([Id], [Nombre]) VALUES (3, N'Profesor C')
INSERT [dbo].[Profesor] ([Id], [Nombre]) VALUES (4, N'Profesor D')
INSERT [dbo].[Profesor] ([Id], [Nombre]) VALUES (5, N'Profesor E')
SET IDENTITY_INSERT [dbo].[Profesor] OFF
GO
ALTER TABLE [dbo].[EstudianteMateria]  WITH CHECK ADD FOREIGN KEY([EstudianteId])
REFERENCES [dbo].[Estudiante] ([Id])
GO
ALTER TABLE [dbo].[EstudianteMateria]  WITH CHECK ADD FOREIGN KEY([MateriaId])
REFERENCES [dbo].[Materia] ([id])
GO
/****** Object:  StoredProcedure [dbo].[spDeleteEstudiante]    Script Date: 14/05/2025 7:59:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteEstudiante]
	-- Add the parameters for the stored procedure here
    @Id INT
AS
BEGIN
	SET NOCOUNT ON;

    DELETE FROM Estudiante
    WHERE Id = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[spListCredito]    Script Date: 14/05/2025 7:59:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spListCredito] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
 SET NOCOUNT ON;

    -- Insert statements for procedure here
   SELECT Id, TotalCredito
    FROM Credito
END
GO
/****** Object:  StoredProcedure [dbo].[spListEstudiante]    Script Date: 14/05/2025 7:59:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author,,Name>
-- Create date: <Create Date,,>
-- Description: Lista los estados y sus identificadores desde la tabla Roulette
-- =============================================
CREATE PROCEDURE [dbo].[spListEstudiante]
    -- Parámetros opcionales si necesitas filtrar resultados en el futuro
    @Filter BIT = NULL -- Ejemplo: Parámetro opcional para filtrar por estado
AS
BEGIN
    SET NOCOUNT ON; -- Evita mensajes informativos innecesarios

    BEGIN TRY
        -- Consultar datos, con opción de filtro si es necesario
       select Id, Nombre, CreditoId from Estudiante
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spListMateria]    Script Date: 14/05/2025 7:59:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListMateria] 
AS
BEGIN
    SELECT Id, Nombre,ProfesorId FROM Materia
END
GO
/****** Object:  StoredProcedure [dbo].[spSaveEstudiante]    Script Date: 14/05/2025 7:59:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSaveEstudiante]
    @Nombre NVARCHAR(100),
    @CreditoId INT,
    @IdEstudiante INT OUTPUT
AS
BEGIN
    INSERT INTO Estudiante (Nombre, CreditoId)
    VALUES (@Nombre, @CreditoId);

    SET @IdEstudiante = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateEstudiante]    Script Date: 14/05/2025 7:59:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateEstudiante] 
	  @Id INT,
     @Nombre NVARCHAR(100)
AS
BEGIN
	  SET NOCOUNT ON;

    UPDATE Estudiante
    SET Nombre = @Nombre
    WHERE Id = @Id;
END
GO
USE [master]
GO
ALTER DATABASE [Estudiantes] SET  READ_WRITE 
GO
