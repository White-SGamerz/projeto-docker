# Estágio 1: Build (Compilação)
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /app
# Copia apenas o pom.xml primeiro para aproveitar o cache das dependências
COPY pom.xml .
RUN mvn dependency:go-offline

# Copia o código fonte e gera o jar
COPY src ./src
RUN mvn clean install -DskipTests

# Estágio 2: Execução (Runtime)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# O nome do JAR deve bater com o que o Maven gera no estágio anterior
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]