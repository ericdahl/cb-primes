# cb-primes
Sample web service with Chicago Boss web framework


#### Quick Start

Prerequisites: Erlang and rebar

##### Build project
```bash
$ make
```

##### Start Server

```bash
$ ./init-dev.sh
````

Open
- [http://localhost:8001/primes/index/](http://localhost:8001/primes/index/)
    - to view list of cached primes
- [http://localhost:8001/primes/index/37](http://localhost:8001/primes/index/37)
    - to get response indicating whether 37 is prime
