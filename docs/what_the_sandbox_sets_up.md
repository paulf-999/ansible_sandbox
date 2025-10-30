# ⚙️ What the Sandbox Sets Up

This page explains what the Ansible Sandbox builds for you when you run the setup commands.

It’s written for first-time users — no prior Ansible experience required.

---

## 🧩 Overview

When you follow the quick-start steps, the sandbox creates a **tiny local environment** that mimics how Ansible works in the real world — but safely, on your own machine.

Everything it builds is **temporary and disposable**. You can tear it down anytime with `make clean`.

---

## 🐳 1. Two Local “Test Machines”

- **What they are:** Docker containers running Ubuntu.
- **Why:** They act as pretend servers, giving Ansible something real to connect to and manage.
- **Names:** `node1` and `node2`.

```bash
make install
````

creates and prepares these containers automatically.

---

## 📜 2. A Machine List (the *Inventory*)

* **File:** `inventories/dev/inventory.ini`
* **Purpose:** Tells Ansible *where* your machines are and *how* to reach them.

Example:

```ini
[all]
node1 ansible_host=127.0.0.1
node2 ansible_host=127.0.0.1
```

Think of it as a phone book for Ansible.

---

## 🧰 3. An Automation File (the *Playbook*)

* **File:** `playbooks/site.yml`
* **Purpose:** Describes *what to do* on each machine — for example, pinging them or creating a test file.

Example task:

```yaml
- name: Create a test file
  ansible.builtin.copy:
    dest: /tmp/hello_ansible.txt
    content: "Hello from Ansible!"
```

---

## 🗂️ 4. A Familiar Folder Structure

The project follows the same layout used in production Ansible repositories, so skills you learn here transfer directly later.

```
inventories/   → defines environments and variables
playbooks/     → defines automation steps
roles/         → reusable logic (you can add your own later)
src/           → helper scripts and Make targets
```

---

## 🧹 5. Safe Reset and Re-run

You can rebuild the entire sandbox anytime:

```bash
make clean && make install && make run
```

---

## 🧠 In Short

The sandbox builds:

| Element               | Purpose                        | File/Command                           |
| --------------------- | ------------------------------ | -------------------------------------- |
| Two Docker containers | The “machines” Ansible manages | `make install`                         |
| Inventory             | Where those machines live      | `inventories/dev/inventory.ini`        |
| Playbook              | What Ansible should do         | `playbooks/site.yml`                   |
| Folder layout         | Mirrors real-world projects    | `inventories/`, `playbooks/`, `roles/` |
| Cleanup               | Reset everything safely        | `make clean`                           |

---

✅ **Result:**
You get a small, repeatable environment to see how Ansible connects, runs tasks, and reports results — all without touching any real infrastructure.
