# Counts
A domain-counter data store

### Problem
* Is this URI in my spam list? (spam list over a million entries)
* How many users like my post? (a like being subject to change)
* How may times did oliver watch this video? (counting frequencies)
* How many unique users visited my website in the last 3 hours? (sliding hyperloglog)


### TODO
- [ ] Design and implement REST API 
- [ ] Create counter manager
- [ ] Integrate Immutable Counter (Hyperloglog++)
- [ ] Integrate Mutable Counter (CuckooFilter and possibly play with the idea of CuckooLogLog)
- [ ] Integrate Frequency Counter (minCount)
- [ ] Integrate Expiring Counter (Sliding Hyperloglog)
- [ ] Store to Disk
- [ ] Replication on multiple servers