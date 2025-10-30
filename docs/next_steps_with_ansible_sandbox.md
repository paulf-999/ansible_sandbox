# 🌱 Next Steps with the Ansible Sandbox

Once you’ve completed the Quick Start, you’ll have a working local Ansible setup.
This page outlines some **practical directions to expand your learning**.

---

## 1️⃣ Add Variables & Templates
Use `vars:` blocks or external YAML files to parameterise tasks and render dynamic content with Jinja2 templates.
→ Helps you avoid hard-coding paths or usernames.

---

## 2️⃣ Introduce Roles
Move repeated logic into reusable, modular roles (e.g. `docker_runtime`, `airflow_single_node`).
→ See [docs/ansible_roles_example.md](ansible_roles_example.md) for a reference pattern.

---

## 3️⃣ Add Molecule Tests
Use [Molecule](https://molecule.readthedocs.io/) to lint and test your roles automatically.
→ Gives fast feedback that your Ansible code behaves as expected.

---

## 4️⃣ Use Ansible Vault
Encrypt sensitive data such as passwords or API keys with `ansible-vault encrypt`.
→ Ensures secrets are never stored in plain text.

---

## 5️⃣ Integrate CI/CD
Add a lightweight pipeline (e.g. GitHub Actions or Azure DevOps) to run `ansible-lint` and syntax checks on commit.
→ Builds good habits for production-grade repositories.

---

## 6️⃣ Target Remote Hosts
Swap the local Docker setup for real VMs or EC2 instances (SSH-based connections).
→ Lets you practise managing actual infrastructure safely.

---

✅ **In short:**
Start simple, make one small improvement at a time, and you’ll naturally move from sandbox experiments to reliable automation projects.
