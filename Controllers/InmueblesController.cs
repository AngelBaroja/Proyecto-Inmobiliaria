using Microsoft.AspNetCore.Mvc;
using Proyecto_Inmobiliaria.Models;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using System.Linq;

namespace Proyecto_Inmobiliaria.Controllers 
{
    public class InmueblesController : Controller
    {
        private readonly RepositorioInmueble repositorioInmueble; 
        private readonly RepositorioPropietario repositorioPropietario;
        public InmueblesController(IConfiguration config)
        {
            this.repositorioInmueble = new RepositorioInmueble(config);
            this.repositorioPropietario = new RepositorioPropietario(config);
        }        

        // GET: Inmuebles
        public IActionResult Index(int? pagina = 1)
        {
            var inmuebles = repositorioInmueble.ObtenerTodos().OrderBy(i => i.Id);

            int pageNumber = pagina ?? 1; // Si pagina es null, usar 1
            int pageSize = 5;

            int totalPaginas = (int)Math.Ceiling((double)inmuebles.Count() / pageSize);

            ViewBag.Pagina = pageNumber;
            ViewBag.TotalPaginas = totalPaginas;

            var inmueblesPaginados = inmuebles
                .Skip((pageNumber - 1) * pageSize)
                .Take(pageSize);

            return View(inmueblesPaginados);
        }

        // GET: Inmuebles/Create
        public IActionResult Create()
        {
            var propietarios = repositorioPropietario.ObtenerTodos().Select(p => new SelectListItem
            {
                Text = $"{p.Nombre} {p.Apellido} / {p.Dni}", // Texto a mostrar en la lista desplegable
                Value = p.Id.ToString() // Valor que se enviará al servidor
            }).ToList();
            ViewBag.Propietarios = propietarios;
            return View();
        }

        // POST: Inmuebles/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Inmueble inmueble)
        {
            if (ModelState.IsValid)
            {
                repositorioInmueble.Alta(inmueble);
                return RedirectToAction(nameof(Index));
            }
            return View(inmueble);
        }

        // GET: Inmuebles/Edit/{id}
        public IActionResult Edit(int id)
        {
            var inmueble = repositorioInmueble.ObtenerPorId(id);
            if (inmueble == null)
            {
                return NotFound();
            }
            
            var propietarios = repositorioPropietario.ObtenerTodos().Select(p => new SelectListItem
            {
                Text = $"{p.Nombre} {p.Apellido} / {p.Dni}", // Texto a mostrar en la lista desplegable
                Value = p.Id.ToString() // Valor que se enviará al servidor
            }).ToList();
            ViewBag.Propietarios = propietarios;
            inmueble.Propietario = repositorioPropietario.ObtenerPorId(inmueble.IdPropietario);
            return View(inmueble);
        }

        // POST: Inmuebles/Edit/{id}
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, Inmueble inmueble)
        {
            if (id != inmueble.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                repositorioInmueble.Modificacion(inmueble);
                return RedirectToAction(nameof(Index));
            }
            
            inmueble.Propietario = repositorioPropietario.ObtenerPorId(inmueble.IdPropietario);
            return View(inmueble);
        }

        // GET: Inmuebles/Eliminar/{id}
        public IActionResult Eliminar(int id)
        {
            var inmueble = repositorioInmueble.ObtenerPorId(id);
            if (inmueble == null)
            {
                return NotFound();
            }
            return View(inmueble);
        }

        // POST: Inmuebles/Eliminar/{id}
        [HttpPost, ActionName("Eliminar")]
        [ValidateAntiForgeryToken]
        public IActionResult EliminarConfirmed(int id)
        {
            repositorioInmueble.Baja(id);
            return RedirectToAction(nameof(Index));
        }
    }
}
