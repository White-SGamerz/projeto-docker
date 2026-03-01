# Ambiente de Desenvolvimento Dockerizado: Debian 13 em VirtualBox no Windows 10

Este projeto documenta a criação de uma infraestrutura de desenvolvimento isolada, utilizando uma Máquina Virtual (VM) para containerizar aplicações, neste caso usei um projeto de teste com Java Spring Boot, permitindo um fluxo de trabalho profissional entre o Host (Windows) e o Guest (Linux).

## 🎯 Objetivo
O intuito deste ambiente é separar a camada de desenvolvimento (codificação no Windows) da camada de execução e infraestrutura (Docker no Debian), preparando o terreno para estudos avançados de **DevOps, CI/CD e Kubernetes**.

## 🛠️ Especificações Técnicas
* **SO Guest**: Debian 13 (Trixie)
* **Virtualizador**: Oracle VM VirtualBox 7.x
* **Recursos da VM**: 4096 MB RAM | 2 CPUs (Otimizado para i5-9400F)
* **Container Engine**: Docker Engine 24+
* **Linguagem Base**: Java 17 (Eclipse Temurin)

---

## 🚀 A Jornada: Desafios e Soluções

A conclusão deste ambiente foi fruto de um processo de **Troubleshooting** e tomada de decisões arquiteturais:

### 1. Superando Limitações de Distros Minimalistas
Inicialmente, tentei utilizar distribuições como o *antiX*, visando baixo consumo de recursos, pois o curso de Kubernetes que estou fazendo na UDEMY, já havia me instruido usa-lo. No entanto, a falta de pacotes atualizados e erros de assinatura de repositórios impediram a instalação estável do Docker.
* **Solução**: Migração para o **Debian 13**, garantindo um kernel moderno e suporte nativo às ferramentas de containerização.

### 2. Superando o "Build Failure" (Docker Images)
Durante a criação do `Dockerfile`, enfrentei erros de resolução de imagens base (`openjdk:8-jre-alpine: not found`).
* **Solução**: Atualização para imagens oficiais e mantidas pela comunidade (**Eclipse Temurin**), utilizando **Multi-stage Build** para reduzir o tamanho final da imagem.

### 3. Comunicação entre Sistemas (Host vs. Guest)
O desafio era acessar a aplicação Java rodando no container dentro do Linux através do navegador no Windows.
* **Solução**: Implementação de **Port Forwarding** (Redirecionamento de Portas) no VirtualBox, mapeando a porta `8080` do Host para a porta `8080` da VM.

---

## 🏗️ Fluxo de Trabalho Implementado

O ambiente segue o padrão de **Integração via Git**:

1.  **Desenvolvimento**: O código é escrito no Windows (VS Code/IntelliJ).
2.  **Versionamento**: `git push` envia as alterações para o repositório remoto.
3.  **Deploy Local**: No terminal do Debian, é executado o `git pull`.
4.  **Containerização**: 
    ```bash
    docker build -t meu-projeto-java .
    docker run -d -p 8080:8080 meu-projeto-java
    ```
5.  **Validação**: Acesso via `http://localhost:8080` no Windows.

## 📈 Conclusão e Próximos Passos
Este ambiente provou-se resiliente e escalável. Com o Docker estabilizado, o próximo marco deste repositório será a implementação de manifestos de **Kubernetes (K8s)**, explorando objetos como *Deployments*, *Services* e *ConfigMaps* dentro deste ecossistema virtualizado.
Com isso, o projeto pode evoluir para aplicar CI/CD e tornar a aplicação altamente escalável.
