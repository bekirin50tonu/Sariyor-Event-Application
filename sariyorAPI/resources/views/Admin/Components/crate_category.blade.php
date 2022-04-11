@if ($errors->any())
    <div class="alert alert-danger">
        <ul>
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    </div>
@endif
<form action="{{route('admincategorycreate')}}" enctype="multipart/form-data" method="POST">
    @csrf
    <div class="form-group">
        <label for="category_name_field">Category Name</label>
        <input type="text" class="form-control" id="category_name_field" name="cat_name"
               aria-describedby="category_name" placeholder="Enter Category Name">
    </div>
    <div class="form-group">
        <label for="category_image_field">Image</label>
        <input type="file" class="form-control" id="category_image_field" name="cat_image"
               placeholder="Select Image">
    </div>
    <br><br>
    <button type="submit" class="btn btn-primary">Submit</button>
</form>
