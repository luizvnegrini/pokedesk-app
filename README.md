# Luiz Negrini's Pokedesk

An app that show information about pokemons.

## SETUP

### 0 Install Flutter Framework

[See docs here.](https://docs.flutter.dev/get-started/install)


### 1 Lefthook

Used to configure Git Hooks in the project. Performs some checks before commits or pushes.

Documentation with installation manual [here.](https://github.com/evilmartians/lefthook/blob/master/docs/full_guide.md)

After installation, access the project root and run:

```bash
lefthook install -f
```

## **2. Running the project**

To run, take into account the flavors `dev`, `hml` e `prod`.  

Each flavor has a configuration file inside the folder `base_app/.env`.  

Always run as follows:  

```bash
bash scripts.sh -get
cd base_app
flutter run -t lib/main-<flavor>.dart --flavor <flavor> 
```

## **3. Tests**

To maintain organization, each test file must be created in the same folder structure as the file being tested. Example:

```bash
# Implementation
/lib
  /domain
    /usecases
      /remote_auth.dart

# Test
/test
  /domain
    /usecases
      /remote_auth_test.dart
```

## **4. Standards and best practices**

Project configured with [Flutter Lints](https://pub.dev/packages/flutter_lints) package.

### **5. Commits**

Standardization of commit messages must be maintained. You must follow the pattern specified in [Conventional Commits.](https://www.conventionalcommits.org/pt-br/v1.0.0/)

It is mandatory to always have a type in the commit message.
*This validation is done automatically by Lefthook at commit time.*

Accepted prefixes: build, chore, ci, docs, feat, fix, perf, refactor, revert, style, test


## **7. Critique**