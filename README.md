# ScadaBR 1.2 – Docker + MySQL (Startup Safe)

Este repositório fornece um ambiente **ScadaBR 1.2** totalmente funcional utilizando **Docker Compose**.

A solução implementada garante que o **Tomcat só inicia após o MySQL estar disponível**, tornando o ambiente **estável, previsível e pronto para produção**.

---

## ✅ Principais características

* ScadaBR 1.2 em **Tomcat 9 (JDK 11)**
* MySQL 5.7 com **persistência via volume**
* **Correção de race condition** entre ScadaBR e MySQL
* Inicialização segura usando `wait-for-mysql.sh`
* Uploads persistentes
* Timezone correto (`America/Sao_Paulo`)
* Encoding UTF-8
* Rebuild da imagem **sem perda de dados**
* Scripts de backup (dump e volume)

---

## 📦 Estrutura do projeto

```bash
.
├── docker-compose.yml
├── Dockerfile
├── wait-for-mysql.sh
├── setenv.sh
├── backup_mysql_dump.sh
├── backup_mysql_volume.sh
├── ScadaBR/                # aplicação já extraída (exploded)
│   ├── WEB-INF/
│   ├── images/
│   ├── resources/
│   └── uploads/            # sobrescrito por volume
└── backup/
    └── mysql/
        └── dumps/
```

---

## 🚀 Como subir o ambiente

### 1️⃣ Instalar Docker

```bash
curl -fsSL https://get.docker.com | bash
```

### 2️⃣ Subir o stack

```bash
docker compose up -d --build
```

A inicialização agora segue a ordem correta:

1. MySQL sobe
2. ScadaBR aguarda MySQL
3. Tomcat inicia
4. Banco é inicializado corretamente

---

## 🌐 Acesso

* **ScadaBR:** [http://localhost:8080/ScadaBR](http://localhost:8080/ScadaBR)
* **MySQL:** porta 3306 (uso interno)

---

## 🔑 Credenciais padrão

### ScadaBR

* Usuário: `admin`
* Senha: `admin`

### MySQL

* Database: `scadabr`
* Usuário: `scadabr`
* Senha: `scadabr`

---

## 💾 Persistência de dados

| Item                      | Persistência  |
| ------------------------- | ------------- |
| Banco de dados            | Volume Docker |
| Uploads                   | Volume Docker |
| Data Sources / Históricos | MySQL         |

⚠️ **Nunca utilize em produção**:

```bash
docker compose down -v
```

Esse comando ira apagar tudo, e você ira perder seus dados do scadabr.

---

## 🗄️ Backup do MySQL

### 1️⃣ Backup lógico (mysqldump)

```bash
chmod +x backup_mysql_dump.sh
./backup_mysql_dump.sh
```

Gera arquivos em:

```
backup/mysql/dumps/
```

Inclui:

* estrutura
* dados
* triggers
* procedures

---

### 2️⃣ Backup físico do volume

```bash
chmod +x backup_mysql_volume.sh
./backup_mysql_volume.sh
```
Gera arquivos em:

```
backup/volumes/mysql/
```

⚠️ Use apenas para **disaster recovery**
⚠️ Compatível somente com **MySQL 5.7 → 5.7**

---

## ☕ JVM / Tomcat (`setenv.sh`)

```bash
export JAVA_OPTS="-Xms512m -Xmx2048m -XX:+UseG1GC -Djava.awt.headless=true -Dfile.encoding=UTF-8 
-Dsun.jnu.encoding=UTF-8 -Duser.timezone=America/Sao_Paulo -Djava.util.PropertyResourceBundle.encoding=UTF-8"
```

---

## 📄 Licença

Este repositório é apenas para fins educacionais e de infraestrutura.
O ScadaBR é um software open-source mantido por seus respectivos autores.
