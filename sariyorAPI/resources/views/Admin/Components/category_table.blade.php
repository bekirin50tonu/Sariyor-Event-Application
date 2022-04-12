<table class="table">
    <thead>
    <tr>
        <th scope="col">#</th>
        <th scope="col">Image</th>
        <th scope="col">Name</th>
        <th scope="col">Extensions</th>
    </tr>
    </thead>
    <tbody>
    @foreach($categories as $category)
        <tr>
            <th scope="row">{{$category->id}}</th>
            <td>
                @if($category->image_path)
                    <img src="{{route('imagecategory',$category->image_path)}}" width="100"
                         height="100"
                         alt="{{$category->name}}">
                @else
                    <p>Nope</p>,
                @endif
            </td>
            <td>{{$category->name}}</td>
            <td>
                <div class="d-flex gap-4">
                    <button class="btn btn-warning" data-bs-toggle="modal"
                            data-bs-target="#exampleModal{{$category->id}}">Update
                    </button>
                    <form action="{{route('admincategorydelete',$category->id)}}" method="POST">
                        @csrf
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </div>
                @include('admin.components.modal_form')
            </td>
        </tr>
    @endforeach
    </tbody>
</table>
