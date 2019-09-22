# Piscine Python

# Day01 - NumPy

Today you will learn how to use the Python library that will allow you to manipulate multidimensional arrays and perform complex mathematical operations on matrices.

## Notions of the day

NumPy array, slicing, stacking, dimensions, broadcasting, normalization

## General rules

- Use the NumPy Library : use NumPy's built-in functions as much as possible. Here you will be given no credit for reinventing the wheel.

## Helper

For this day you will use the image provided at the root of this folder.

```
export ....
install ....
```

### Exercise 00 - NumPy Array Creator

Ici l'étudiant apprend à créer un NumPy array à partir de différentes structrues de départ:
- Une liste
- Un tuple
- Un itérable (ex range(5))
- Un array avec des dimensions spécifiées, mais dont les valeurs peuvent être:
    - des 0
    - des 1
    - une valeur n
    - rien du tout

### Exercise 01 - Image Loader

L'étudiant doit écrire un script qui lit le fichier image attaché (à trouver) et le transforme en NumPy array.

Il doit ensuite pouvoir:
- Afficher les dimensions de l'Image
- la tronquer
- afficher un pixel sur deux (avec le slicing)


### Exercise 02 - Stacking and resizing

On demande à l'étudiant d'effectuer des "collages" d'image:
- Juxtaposition horizontale (hstack)
- Même chose à la verticale
- Une mosaique

Aussi: redimensionnement de l'Image

### Exercise 03 - Broadcasting

Créer un array à dimension flottante qui devra être appliqué à l'image.
(à développer)

### Exercise 04 - Color filters

Manipulations de certaines couleurs
- Enlever le bleu
- Inverser les couleurs

Application de filtres simples avec np.vectorize

Transformer en noir et blanc


### Exercise 05 - Advanced modifications

Application de filtres plus complexes:
- Appliquer un flou sur l'Image
- Détection de contours
- Autres filtres en bonus
