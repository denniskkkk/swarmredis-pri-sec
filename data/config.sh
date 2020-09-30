!#/bin/bash
if grep -q "vm.overcommit_memory" /etc/sysctl.conf; then \
    sed -i -e 's/^.vm.overcommit_memory.*/vm.overcommit_memory = 1/g'  /etc/sysctl.conf; \
    else
        echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf; \
    fi
