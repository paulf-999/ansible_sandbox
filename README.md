# 🧪 Ansible Sandbox

A lightweight local environment for experimenting with Ansible using Docker containers.

---

## 🚀 Quick start

### 1. Install dependencies

```bash
make deps
```

---

### 2. Create test containers

```bash
docker run -d --name node1 --hostname node1 ubuntu:22.04 sleep infinity
docker run -d --name node2 --hostname node2 ubuntu:22.04 sleep infinity
```

---

### 3. Install Python inside the containers

Ansible requires Python to be installed on managed hosts.

```bash
docker exec -it node1 apt-get update && docker exec -it node1 apt-get install -y python3
docker exec -it node2 apt-get update && docker exec -it node2 apt-get install -y python3
```

---

### 4. Create an Ansible inventory

Create a file called `inventory.ini`:

```ini
[nodes]
node1 ansible_connection=docker
node2 ansible_connection=docker
```

---

### 5. Write a simple playbook

Create `test_playbook.yml`:

```yaml
- name: Test Ansible on local Docker containers
  hosts: nodes
  gather_facts: yes
  tasks:
    - name: Ping all nodes
      ansible.builtin.ping:

    - name: Create a test file
      ansible.builtin.file:
        path: /tmp/hello_ansible.txt
        state: touch
```

---

### 6. Run the playbook

```bash
ansible-playbook -i inventory.ini test_playbook.yml
```

Verify the file was created:

```bash
docker exec -it node1 ls /tmp/
docker exec -it node2 ls /tmp/
```

---

## 🧹 Housekeeping

Remove the containers:

```bash
make clean
```
