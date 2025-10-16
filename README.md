Perfect — here’s your **updated and aligned README**, revised to:

* reflect the new Makefile flow (`make install` instead of manual Docker commands)
* merge steps 2 + 3 (“create & prepare containers”)
* clean up references to pipx (since you’re now using pip)
* add a few small phrasing improvements for readability.

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

### 1. Install dependencies

```bash
make deps
```

Installs the required Python dependencies (Ansible and related tools) using `pip`.

---

### 2. Create and prepare test containers

```bash
make install
```

This command:

1. Creates two Ubuntu containers (`node1`, `node2`) to act as Ansible-managed nodes.
2. Installs Python inside each container (required by Ansible to run modules).
3. Verifies that your `inventory.ini` and `test_playbook.yml` files exist.

After completion, you’ll have two ready-to-use Ansible hosts running locally.

---

### 3. Run the playbook

```bash
make run
```

This executes the sample playbook (`test_playbook.yml`) against the two Docker nodes defined in `inventory.ini`.

Verify that the playbook ran successfully by checking for the created file:

```bash
docker exec -it node1 ls /tmp/
docker exec -it node2 ls /tmp/
```

You should see `hello_ansible.txt` listed on both nodes.

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

Would you like me to add a short **“Next steps / ideas for expansion”** section at the bottom (e.g. add variables, use roles, integrate Molecule)? It would make this README a bit more forward-looking for when you share it with your wider team.
