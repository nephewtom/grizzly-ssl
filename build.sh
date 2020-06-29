#!/bin/bash

# To use this script, jar with dependencies needs to be built first.
# Use 'mvn package' to build it once, and then use this script for quicker compile.

javac -cp target/grizzly-poc-1.0-SNAPSHOT.jar src/main/java/org/*.java
# mvn compile
