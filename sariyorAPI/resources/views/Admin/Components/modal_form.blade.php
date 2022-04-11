<div class="modal fade" id="exampleModal{{$category->id}}" tabindex="-1" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Update Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="{{route('admincategoryupdate',$category->id)}}" method="POST"
                      enctype="multipart/form-data">
                    @csrf
                    <div class="form-group">
                        <label for="cat_name">Category Name</label>
                        <input type="text" class="form-control" id="cat_name" aria-describedby="cat_name" name="cat_name"
                               placeholder="Enter Category Name" value="{{$category->name}}">
                    </div>
                    @if($category->image_path)
                        <img src="{{route('imagecategory',$category->image_path)}}" class="img-thumbnail"
                             alt="{{$category->name}}">
                    @endif
                    <div class="form-group">
                        <label for="cat_image">Image</label>
                        <input type="file" class="form-control" id="cat_image" placeholder="Image" name="cat_image">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
