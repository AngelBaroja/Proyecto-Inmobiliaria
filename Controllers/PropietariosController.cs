using Microsoft.AspNetCore.Mvc;
using Proyecto_Inmobiliaria.Net_Core.Models;
using System.Collections.Generic;
using System.Linq;

namespace Proyecto_Inmobiliaria.Net_Core.Controllers
{
    public class PropietariosController : Controller
    {
        private readonly RepositorioPropietario repositorioPropietario;

        public PropietariosController(RepositorioPropietario _repositorioPropietario)
        {
            repositorioPropietario = _repositorioPropietario;
        }

        // GET: Propietarios
        public IActionResult Index()
        {
            var propietarios = repositorioPropietario.ObtenerTodos();
            return View(propietarios);
        }

        // GET: Propietarios/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Propietarios/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Propietario propietario)
        {
            propietario.Estado = true; // Establecer estado por defecto a true
            if (ModelState.IsValid)
            {
                repositorioPropietario.Alta(propietario);
                return RedirectToAction(nameof(Index));
            }
            return View(propietario);
        }

        // GET: Propietarios/Edit/5
        public IActionResult Edit(int id)
        {
            var propietario = repositorioPropietario.ObtenerPorId(id);           
            return View(propietario);
        }

        // POST: Propietarios/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, Propietario propietario)
        {
            if (id != propietario.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                
                //propietario.Estado = propietario.Estado ?? false; // Establece a false si no se proporciona
                repositorioPropietario.Actualizar(propietario);
                return RedirectToAction(nameof(Index));
            }
            return View(propietario);
        }

        // GET: Propietarios/Eliminar/5
        public IActionResult Eliminar(int id)
        {
            var propietario = repositorioPropietario.ObtenerPorId(id);            
            return View(propietario);
        }

        // POST: Propietarios/Eliminar/5
        [HttpPost, ActionName("Eliminar")]
        [ValidateAntiForgeryToken]
        public IActionResult EliminarConfirmed(int id)
        {
            repositorioPropietario.Baja(id);
            return RedirectToAction(nameof(Index));
        }
    }
}