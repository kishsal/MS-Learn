# Create a web UI with ASP.NET Core (https://docs.microsoft.com/en-us/learn/modules/create-razor-pages-aspnet-core/1-introduction)

1) Ensure you have .NET 6.0 installed
```
dotnet --list-sdks
```

2) Create a folder called "RazorsPagesPizza"

3) Open terminal from the new folder

4) Create a basic web app project
```
dotnet new webapp -f net6.0
```

5) Generate a developer certificate run 'dotnet dev-certs https'

6) Compile and Run the project
```
dotnet run
```

7) Open the browser and navigate to https://localhost:7157

8) Create a new page
```
dotnet new page --name Pizza --namespace RazorPagesPizza.Pages --output Pages
```

9) Create a Models directory on the project root

10) Create a file called Pizza.cs in the Models directory

11) Insert the following code:
```
using System.ComponentModel.DataAnnotations;

namespace RazorPagesPizza.Models;

public class Pizza
{
    public int Id { get; set; }

    [Required]
    public string? Name { get; set; }
    public PizzaSize Size { get; set; }
    public bool IsGlutenFree { get; set; }

    [Range(0.01, 9999.99)]
    public decimal Price { get; set; }
}

public enum PizzaSize { Small, Medium, Large }
```

12) Create a Services directory on the project root

13) Create a file called PizzaService.cs in the Services directory

14) Insert the following code:
```
using RazorPagesPizza.Models;

namespace RazorPagesPizza.Services;
public static class PizzaService
{
    static List<Pizza> Pizzas { get; }
    static int nextId = 3;
    static PizzaService()
    {
        Pizzas = new List<Pizza>
                {
                    new Pizza { Id = 1, Name = "Classic Italian", Price=20.00M, Size=PizzaSize.    Large, IsGlutenFree = false },
                    new Pizza { Id = 2, Name = "Veggie", Price=15.00M, Size=PizzaSize.Small,     IsGlutenFree = true }
                };
    }

    public static List<Pizza> GetAll() => Pizzas;

    public static Pizza? Get(int id) => Pizzas.FirstOrDefault(p => p.Id == id);

    public static void Add(Pizza pizza)
    {
        pizza.Id = nextId++;
        Pizzas.Add(pizza);
    }

    public static void Delete(int id)
    {
        var pizza = Get(id);
        if (pizza is null)
            return;

        Pizzas.Remove(pizza);
    }

    public static void Update(Pizza pizza)
    {
        var index = Pizzas.FindIndex(p => p.Id == pizza.Id);
        if (index == -1)
            return;

        Pizzas[index] = pizza;
    }
                }
```

15) Replace the contents of Pages/Pizza.cshtml with the following code:
```
@page
@using RazorPagesPizza.Models
@model RazorPagesPizza.Pages.PizzaModel
@{
    ViewData["Title"] = "Pizza List";
}

<h1>Pizza List 🍕</h1>
<form method="post" class="card p-3">
    <div class="row">
        <div asp-validation-summary="All"></div>
    </div>
    <div class="form-group mb-0 align-middle">
        <label asp-for="NewPizza.Name">Name</label>
        <input type="text" asp-for="NewPizza.Name" class="mr-5">
        <label asp-for="NewPizza.Size">Size</label>
        <select asp-for="NewPizza.Size" asp-items="Html.GetEnumSelectList<PizzaSize>()" class="mr-5"></select>
        <label asp-for="NewPizza.Price"></label>
        <input asp-for="NewPizza.Price" class="mr-5" />
        <label asp-for="NewPizza.IsGlutenFree">Gluten Free</label>
        <input type="checkbox" asp-for="NewPizza.IsGlutenFree" class="mr-5">
        <button class="btn btn-primary">Add</button>
    </div>
</form>
<table class="table mt-5">
    <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Price</th>
            <th scope="col">Size</th>
            <th scope="col">Gluten Free</th>
            <th scope="col">Delete</th>
        </tr>
    </thead>
    @foreach (var pizza in Model.pizzas)
    {
        <tr>
            <td>@pizza.Name</td>
            <td>@($"{pizza.Price:C}")</td>
            <td>@pizza.Size</td>
            <td>@Model.GlutenFreeText(pizza)</td>
            <td>
                <form method="post" asp-page-handler="Delete" asp-route-id="@pizza.Id">
                    <button class="btn btn-danger">Delete</button>
                </form>
            </td>
        </tr>
    }
</table>

@section Scripts {
<partial name="_ValidationScriptsPartial" />
}
```

16) 