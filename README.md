# ScadaBR 1.2 – Docker + MySQL (Production Ready)

Este repositório fornece um ambiente **ScadaBR 1.2** totalmente funcional utilizando **Docker Compose**, com:

* MySQL persistente
* ScadaBR já extraído e configurado
* Persistência de uploads
* Timezone correto (America/Sao_Paulo)
* Encoding UTF-8
* Estrutura pronta para rebuild sem perda de dados
* **Rotinas de backup do MySQL (dump e volume)**

---

## 📦 Estrutura do projeto

```bash
.
├── docker-compose.yml
├── Dockerfile
├── setenv.sh
├── backup_mysql_dump.sh
├── backup_mysql_volume.sh
├── ScadaBR/
│   ├── WEB-INF/
│   ├── images/
│   ├── resources/
│   └── uploads/   # sobrescrito por volume
└── backup/
    └── mysql/
        └── dumps/
```

---

## 🧠 Arquitetura

* **ScadaBR** roda em Tomcat 9 (JDK 11)
* **MySQL 5.7** como banco de dados
* **Volumes Docker** garantem persistência de dados
* A pasta `uploads/` é persistida separadamente
* Rebuild da imagem **não apaga configurações nem históricos**

---

## 🚀 Como subir o ambiente

```bash
docker compose up -d --build
```

* ScadaBR: http://localhost:8080
* MySQL: porta 3306 (uso interno)

---

## 🔑 Credenciais padrão

### ScadaBR
* Usuário: admin
* Senha: admin

### MySQL
* Database: scadabr
* Usuário: scadabr
* Senha: scadabr

---

## 💾 Persistência de dados

| Item                      | Persistência  |
|---------------------------|---------------|
| Banco de dados            | Volume Docker |
| Uploads                   | Volume Docker |
| Data Sources / Históricos | MySQL         |

⚠️ **Nunca utilize**:
```bash
docker compose down -v
```

---

## 🗄️ BACKUP DO MYSQL

O projeto já inclui **dois métodos de backup**, pensados para ambientes Docker.

---

### 1️⃣ Backup lógico (mysqldump)

Script:
```bash
backup_mysql_dump.sh
```

O que ele faz:
* Gera um arquivo `.sql`
* Inclui estrutura + dados
* Inclui triggers, procedures e routines
* Compatível com restore em qualquer ambiente Docker

Executar:
```bash
chmod +x backup_mysql_dump.sh
./backup_mysql_dump.sh
```

Exemplo de saída:
```text
[INFO] Criando backup lógico do MySQL...
[OK] Backup criado: ./backup/mysql/dumps/scadabr_YYYYMMDD_HHMMSS.sql
```

📁 Os backups ficam em:
```text
backup/mysql/dumps/
```

ℹ️ O script utiliza a flag `--no-tablespaces` para evitar erros de privilégio
(`PROCESS`) comuns em containers MySQL.

---

### 2️⃣ Backup do volume MySQL (backup físico)

Script:
```bash
backup_mysql_volume.sh
```

Esse método:
* Copia diretamente os arquivos do volume MySQL
* Útil para disaster recovery
* Requer restore no **mesmo MySQL major version**

Executar:
```bash
chmod +x backup_mysql_volume.sh
./backup_mysql_volume.sh
```

⚠️ Este tipo de backup **não é portável** entre versões diferentes do MySQL.

---

## ♻️ Restore de backup lógico (dump)

```bash
docker exec -i scadabr-mysql   mysql -uscadabr -pscadabr scadabr < backup/mysql/dumps/arquivo.sql
```

---

## ☕ JVM / Tomcat (`setenv.sh`)

Configuração de memória, encoding e timezone da JVM:

```bash
export JAVA_OPTS="-Xms512m -Xmx2048m -XX:+UseG1GC -Dfile.encoding=UTF-8 -Duser.timezone=America/Sao_Paulo"
```

---

## 📌 Observações importantes

* ScadaBR 1.2 é legado (Mango-based)
* Backup lógico é o método recomendado
* Volumes garantem persistência mesmo após rebuild
* Ambiente pronto para produção e DR básico

---

## 📄 Licença

Este repositório é apenas para fins educacionais e de infraestrutura.
O ScadaBR é um software open-source mantido por seus respectivos autores.

---

## ✅ Status do projeto

✔️ Funcional  
✔️ Persistente  
✔️ Rebuild-safe  
✔️ Backup-ready  
✔️ Produção-ready

