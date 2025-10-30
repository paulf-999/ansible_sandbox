# 📘 Key Ansible Concepts

A short reference to the **core ideas** behind Ansible — and a few you’ll meet once you’re comfortable with the basics.

Use this as a quick refresher when returning to the project.

---

## 🧩 Core (Mandatory) Concepts

| Concept | Description |
|----------|--------------|
| **Inventory** | Lists the hosts or groups of hosts that Ansible manages, and how to connect to them. |
| **Playbook** | A YAML file that defines what Ansible should do on those hosts. |
| **Task** | A single action within a playbook (e.g. create a file, install a package). |
| **Module** | The actual building block that performs work — each task calls a module (e.g. `ping`, `copy`). |
| **Node (Host)** | A system managed by Ansible — in this sandbox, the Docker containers (`node1`, `node2`). |

💡 *If you understand these five concepts, you can already run and modify most playbooks.*

---

## 🌱 Introduced Later (Nice to Know)

| Concept | Description |
|----------|--------------|
| **Role** | A reusable structure that groups related tasks, files, and variables for modular automation. |
| **Variable** | Values that make your playbooks flexible (e.g. paths, usernames, messages). |
| **Template** | A text file with Jinja2 placeholders that render dynamically using variables. |
| **Vault** | Encrypts sensitive data like passwords or API keys within your repo. |

💡 *These are worth revisiting once you’ve customised your first playbook successfully.*

---

## 🧠 Quick mental model

Core flow:
Inventory → Playbook → Tasks → Modules → Nodes

When projects grow:
↑ Add Roles, Variables, Templates, Vaults

> **Think of it as:**

> *Inventory = where* • *Playbooks = what* • *Roles = how* • *Variables/Templates = flexibility*

---

## 📚 Related Reading

For a step-by-step explanation of how these concepts connect in practice, see
➡️ [Introductory Overview of Ansible](introductory_overview_ansible.md)
