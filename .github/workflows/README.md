# About 42AI actions 

## make-it.yml

> On any push, regardless of the branch, this action will attempt to build the PDFs.

## release-it.yml

> Branch : MASTER

For any push on MASTER branch, this action will build the PDFs and publish a new release for the project.

> NB: For the new release to appear, uploaded code must contain a non-existing VERSION. 
> Adapt the content of the file `/version` accordingly.

