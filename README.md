Perfect 👍 — here’s the final **README** with a concise **“Next Steps / Ideas for Expansion”** section added at the end.
It stays in your professional, instructional tone but gives your team clear directions on how to evolve the sandbox further.

---

# 🧪 Ansible Sandbox

A lightweight local environment for experimenting with **Ansible** using **Docker containers**.

This sandbox lets you practise running Ansible playbooks against disposable “nodes” (containers) on your own machine — no external infrastructure or credentials required.

---

## ⚙️ What this sandbox creates

When you complete the setup steps below, you’ll have:

* **Two Docker containers (`node1`, `node2`)**
  → These act as simulated remote hosts that Ansible can manage. Having more than one node lets you practise running playbooks across multiple hosts (e.g. parallel execution, groups, inventories).

* **An Ansible inventory (`inventory.ini`)**
  → A simple text file listing the hosts Ansible will connect to — in this case, the Docker containers.

* **A sample Ansible playbook (`test_playbook.yml`)**
  → A YAML file defining tasks that Ansible will execute on the managed nodes (e.g., pinging the hosts, creating files).

All components are **local and disposable**, so you can safely experiment and tear them down with `make clean`.

---

## 🚀 Quick start

| **Step**                                     | **Command(s)**             | **Description**                                                                                                                                                                                                                                                                                                            |
| -------------------------------------------- | -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🧩 **1. Install dependencies**               | `make deps`    | Installs the required Python dependencies (Ansible and related tools) using `pip`.                                                                                                                                                                                                                                         |
| 🐳 **2. Create and prepare test containers** | `make install` | Creates two Ubuntu containers (`node1`, `node2`) that act as Ansible-managed nodes, installs Python inside each (required for Ansible modules), and verifies that your `inventory.ini` and `test_playbook.yml` files exist. <br><br>After completion, you’ll have two ready-to-use Ansible hosts running locally.          |
| ▶️ **3. Run the playbook**                   | `make run`     | Runs the sample playbook (`test_playbook.yml`) against the two Docker nodes defined in `inventory.ini`. <br><br>To verify success, check for the created file on each node: <br>`bash docker exec -it node1 ls /tmp/<br>docker exec -it node2 ls /tmp/`<br>You should see `hello_ansible.txt` listed on both nodes. |

---

✅ *After completing these steps, you’ll have a working local Ansible environment with disposable Docker-based test nodes.*

---

## 🧹 Housekeeping

When you’re done, remove the containers to restore your environment:

```bash
make clean
```

This stops and removes both containers (`node1`, `node2`).

---

## 📘 Key Ansible Components

| Component     | Description                                                                         |
| ------------- | ----------------------------------------------------------------------------------- |
| **Inventory** | Lists the hosts or groups of hosts that Ansible manages.                            |
| **Playbook**  | A YAML file describing one or more “plays” — sets of tasks to run on defined hosts. |
| **Module**    | A reusable unit of work (e.g. `ping`, `file`, `copy`, `yum`).                       |
| **Task**      | A single module invocation within a playbook.                                       |
| **Node**      | A target system that Ansible connects to and manages (your Docker containers).      |

---

## 🌱 Next steps / ideas for expansion

This sandbox provides the foundation for learning and experimenting with Ansible.
Once you’re comfortable with the basics, here are some directions to explore:

1. **Add Variables & Templates**
   Use `vars:` blocks or external `.yml` files to parameterise tasks and render dynamic content via Jinja2 templates.

2. **Introduce Roles**
   Break playbooks into reusable, modular roles (e.g. `webserver`, `database`) to better reflect real-world structures.

   See [docs/ansible_roles_example.md](docs/ansible_roles_example.md).

3. **Test with Molecule**
   Add [Molecule](https://molecule.readthedocs.io/) for automated linting, testing, and validation of your roles and playbooks.

4. **Use Ansible Vault**
   Practise securely storing secrets or credentials using `ansible-vault encrypt`.

5. **Integrate CI/CD**
   Set up a simple pipeline (e.g. GitHub Actions, Azure DevOps) to run linting or test playbooks automatically on commit.

6. **Explore Different Connection Types**
   Replace the Docker connection plugin with `ssh` to manage remote VMs or EC2 instances for more realistic scenarios.
