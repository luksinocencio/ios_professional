# ios-professional

## Container View Controllers

Container view controllers are view controllers that contain or combine content from other view controllers into a single working interface.

<hr>

## Navigation Controller

There is two ways to control navigation controller:

- push and pop (like stack)
- present and dismiss (like modal)
<hr>

## TabBar Controller

- Each tab contains own view controller
<hr>

## Page ViewController

- container to track your viewcontroller
- call backs asking you for which vc to show next
- UIViewController has many containers and we can swipable between them
<hr>

## UIScrollView

1 .There are two sets of constraints

- inner to scrollview
- outer to scrollview

2 .Everything needs a size

- height if vertical
- width if horizontal

```
stackView.width = scrollView.width
```

### PROS

- Makes anything scroallable
- Minimalist
- Full control
- Good for long pages

### CONS

- Can't easily reload
- No built in affordances
- Auto Layout more complex

<hr>

## UICollectionView

- Use the concept of a flow layout.
- Can create rich complex designs.

### PROS

- Customizable layouts
- Multi-column scrollable
- Can dynamically change layout
- Good for photos in a grid

### CONS

- More complex
- Often overkill

<hr>

## UITableView

- Scrollable vertical list.

### PROS

- Highly performat (reuseIdentifiers)
- Many affordances built in (header, footer, sections)
- Perfect for single column lists

### CONS

- Hard to do complex non-single column layouts

<hr>
