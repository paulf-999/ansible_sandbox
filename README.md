# 🧪 Ansible Sandbox

A lightweight **starter project** for learning and experimenting with **Ansible** locally —
using Docker containers as disposable managed nodes.

✅ **In short:**
This sandbox gives you a reproducible, disposable environment to safely learn Ansible fundamentals — and a structure you can grow into a production-grade project later.

Everything runs locally and can be reset at any time, so it’s safe to experiment.

---

## 📘 Refresher / Further Reading

If you’re returning after a break or new to Ansible, check out:

* [Introductory Overview](docs/introductory_overview_ansible.md) — a practical walkthrough of the minimum setup and flow.
* [Key Ansible Concepts](docs/key_ansible_concepts.md) — a short glossary explaining common terms.
* [What the Sandbox Sets Up](docs/what_the_sandbox_sets_up.md) — explains what’s created when you run the setup commands and how each part fits together.

---

## 🚀 Quick Start

| **Step**                                     | **Command(s)** | **Description**                                                                                                                                                                                                                                                                                  |
| -------------------------------------------- | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 🧩 **1. Install dependencies**               | `make deps`    | Installs the required Python dependencies (Ansible and related tools) using `pip`, and installs any collections listed in `requirements.yml`.                                                                                                                                                    |
| 🐳 **2. Create and prepare test containers** | `make install` | Creates two Ubuntu-based Docker containers (`node1`, `node2`) that act as managed hosts, installs Python inside each (required by Ansible modules), and ensures your inventory and playbook are in place.                                                                                        |
| ▶️ **3. Run the playbook**                   | `make run`     | Executes `playbooks/site.yml` against both containers listed in `inventories/dev/inventory.ini`. <br><br>To verify success, check for the created file on each node:<br>`docker exec -it node1 ls /tmp`<br>`docker exec -it node2 ls /tmp`<br>You should see `hello_ansible.txt` listed on both. |

---

✅ *After completing these steps, you’ll have a working local Ansible setup using Docker containers as managed hosts.*

---

## 🗂️ Project Structure

Here’s the baseline repo layout used by this sandbox:

```bash
.
├── ansible.cfg
├── inventories/
│   └── dev/
│       ├── inventory.ini
│       ├── group_vars/
│       └── host_vars/
├── playbooks/
│   └── site.yml
├── requirements.yml
├── Makefile
├── README.md
└── src/
    └── sh/
        ├── create_docker_containers.sh
        ├── destroy_docker_containers.sh
        └── shell_utils.sh
```

> 💡 *Tip:* `site.yml` and `inventories/dev/inventory.ini` are your main starting points — edit these when you want to try something new.

This mirrors the **standard structure** used for scalable Ansible repositories — where:

| Folder           | Purpose                                                                 |
| ---------------- | ----------------------------------------------------------------------- |
| **inventories/** | Environment-specific inventories (e.g. `dev`, `prod`) and variables.    |
| **playbooks/**   | YAML playbooks that define automation workflows.                        |
| **roles/**       | Modular, reusable roles (e.g. `docker_runtime`). |
| **ansible.cfg**  | Local configuration to make Ansible commands simpler and consistent. |

---

## 🌱 Next Steps

Once you’ve completed the Quick Start, you can start exploring Ansible in more depth.
See [Next Steps with the Ansible Sandbox](docs/next_steps_with_ansible_sandbox.md) for practical ideas on what to try next.
