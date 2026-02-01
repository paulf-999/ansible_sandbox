# 🧪 Ansible Sandbox

A small, role-based **local Ansible environment** using Docker, designed for quick experimentation and easy re-use.

The structure used matches typical real-world Ansible projects.

### 🌐 Example: Deploy a Local Webserver

The sandbox includes an example Ansible playbook that deploys a local webserver inside a Docker container.

---

# 🚦 How to Use This Repo

You don’t need any Ansible knowledge to use this sandbox.

## ⚠️ Prerequisites

Before running anything, you must complete the following:

1. **Ensure Docker Desktop is running**
   The sandbox deploys everything into a local Docker container.

2. **Rename `.env_template` → `.env`**, then add your GitHub PAT inside it:

   ```env
   GIT_PAT_TOKEN=ghp_your_real_token_here
   ```

## ▶️ Running the Example

After completing the prerequisites, run the following commands from the repo root:

```bash
make deps      # install Ansible
make install   # create the Docker container
make run       # apply the example playbook
```

Then visit **[http://localhost](http://localhost)** in your browser
→ You’ll see a test page served from inside the container.

---

# 📜 Summary of the Example Playbook

The example playbook applies two roles to a local Docker container:

1. **`webserver`** → installs nginx and serves a simple “Hello” page
2. **`git_repo_dbt`** → installs git and clones the private `da-etl-dbtanalytics` repo using a PAT

The result:

* nginx running inside the container
* the dbt analytics repo cloned under `/opt`

---

# 📝 How it works (30 seconds)

* `make install` creates an Ubuntu Docker container (`sandbox_webserver`), exposes port 80 → host, installs Python.
* `make run` auto-loads `.env`, providing `GIT_PAT_TOKEN` to Ansible.
* nginx + the cloned repo sit inside the container, not on your machine
* Ansible applies:

  * **webserver** → installs nginx and serves a test HTML page
  * **git_repo_dbt** → clones the private repo into `/opt`
* You visit **[http://localhost](http://localhost)** to see the nginx page from inside the container.


## 📘 Additional Documentation

- [How the Ansible Sandbox Works](docs/how_the_sandbox_works.md)
