
# Table of Contents

1.  [不规则图形面积计算](#org680e95b)
    1.  [土壤项目](#orgc4b1c30)
    2.  [Polygon Triangulation(多边形三角化)](#org2202d8d)
        1.  [step](#orgc16944d)
        2.  [counter clockwise convex vertex](#org466bdf8)
        3.  [counter clockwise](#org32cd2f2)
    3.  [tools](#org40942aa)
        1.  [JTS lib](#orgf245687)
        2.  [GoeGebra](#org54b44b1)
2.  [Git](#org23b661d)


<a id="org680e95b"></a>

# 不规则图形面积计算


<a id="orgc4b1c30"></a>

## 土壤项目

![img](./grid-show-case.png)


<a id="org2202d8d"></a>

## Polygon Triangulation(多边形三角化)

![img](./1.png)

![img](./2.png)


<a id="orgc16944d"></a>

### step

![img](./3.png)
![img](./4.png)
![img](./5.png)


<a id="org466bdf8"></a>

### counter clockwise convex vertex

    def isConvexVertexOnCounterClockWise(start: Vertex, middle: Vertex, end: Vertex): Boolean = {
      (middle.x - start.x) * (end.y - middle.y) - (end.x - middle.x) * (middle.y - start.y) > 0
    }


<a id="org32cd2f2"></a>

### counter clockwise

    def counterClockwiseOrder(polygon: Polygon):Polygon = {
      val edgesSum = getEdges(polygon).map{
        case Edge(Vertex(ax,ay), Vertex(bx,by)) =>
          (bx-ax)*(by+ay)
      }.sum
      if (edgesSum > 0)
        polygon.reverse
      else
        polygon
    }


<a id="org40942aa"></a>

## tools


<a id="orgf245687"></a>

### JTS lib

<https://github.com/locationtech/jts>


<a id="org54b44b1"></a>

### GoeGebra

<https://www.geogebra.org/>


<a id="org23b661d"></a>

# Git

![img](./before-init.png)

    mkdir git-example
    cd git-example
    git init

![img](./after-init.png)

![img](./after-init-tree.png)

    echo Hello World > some.txt
    git status

![img](./touch-status.png)

    git add some.txt
    git status
    git cat-file -t 557db03de997c86a4a028e1ebd3a1ceb225be238
    git cat-file -p 557db03de997c86a4a028e1ebd3a1ceb225be238

![img](./after-add.png)

![img](./after-add-tree.png)

![img](./git-cat-file-blob.png)

    git commit -m "first commit"
    git status

![img](./after-commit.png)

![img](./after-commit-tree.png)

![img](./after-commit-cat.png)

    git checkout -b test-branch

![img](./check-branch.png)

![img](./check-branch-tree.png)

![img](./cat-ref.png)

    echo second commit from a >> some.txt
    git add some.txt
    git commit -m "second commit from a"
    git checkout master
    echo second commit from b >> some.txt
    git add some.txt
    git commit -m "second commit from b"
    git branch master-backup

![img](./before-merge-rebase.png)

    git merge test-branch
    git add some.txt
    git commit

![img](./conflict.png)

![img](./conflict-content.png)

![img](./merge-tree.png)

![img](./merge-log.png)

    git checkout master-backup
    git rebase test-branch
    git add some.txt
    git rebase --continue
    git commit

![img](./rebase.png)

![img](./rebase-cat.png)

![img](./rebase-cat-2.png)

