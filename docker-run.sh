docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --rm -d -p 127.0.0.1:8443:8443 -v $PWD:/home/coder --name code-server-clang8 lyongu/code-server-clang8  --allow-http --no-auth
