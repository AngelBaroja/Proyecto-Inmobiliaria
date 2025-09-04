using Proyecto_Inmobiliaria.Models;
using Microsoft.AspNetCore.Mvc;

namespace Proyecto_Inmobiliaria.Controllers
{
    public class ContratoController : Controller
    {
        private readonly RepositorioContrato repositorio;
        private readonly RepositorioInquilino rinq;
        private readonly RepositorioInmueble rinm;

        public ContratoController(IConfiguration config)
        {
            this.repositorio = new RepositorioContrato(config);
            this.rinq = new RepositorioInquilino(config);
            this.rinm = new RepositorioInmueble(config);
        }
        [HttpGet]
        public ActionResult Index()
        {
            try
            {
                var lista = repositorio.ObtenerTodos();
                foreach (var contrato in lista)
                {
                    contrato.Inquilino = rinq.ObtenerPorId(contrato.idInquilino);
                    contrato.Inmueble = rinm.ObtenerPorId(contrato.idInmueble);
                }
                ViewBag.id = TempData["d"];
                if (TempData.ContainsKey("Mensaje"))
                    ViewBag.Mensaje = TempData["Mensaje"];
                return View(lista);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", $"Error al obtener la lista de inquilinos: {ex.Message}");
                return View();
            }
        }
        [HttpGet]
        public IActionResult Editar(int id)
        {
            ViewBag.Inquilino = rinq.ObtenerTodos();
            ViewBag.Inmueble = rinm.ObtenerTodos();
            if (id > 0)
            {
                var contrato = repositorio.ObtenerPorId(id);
                return View(contrato);
            }
            else
            {
                return View();
            }
        }
        public IActionResult Detalle(int id)
        {
            ViewBag.Inquilino = rinq.ObtenerTodos();
            ViewBag.Inmueble = rinm.ObtenerTodos();
            if (id > 0)
            {
                var contrato = repositorio.ObtenerPorId(id);
                return View(contrato);
            }
            else
            {
                return View();
            }
        }
        [HttpPost]
        public IActionResult Guardar(Contrato contrato)
        {
            if (!ModelState.IsValid)
            {
                return View(contrato);
            }
            if (contrato.id > 0)
            {
                repositorio.Modificacion(contrato);
                TempData["SuccessMessage"] = "Contrato actualizado correctamente.";
            }
            else
            {
                repositorio.Alta(contrato);
                TempData["SuccessMessage"] = "Contrato creado correctamente.";
            }
            return RedirectToAction(nameof(Index));
        }
        [HttpPost]
        public IActionResult Eliminar(int id)
        {
            try
            {
                repositorio.Baja(id);
                TempData["SuccessMessage"] = "Contrato eliminado correctamente.";
            }
            catch (Exception ex)
            {
                TempData["SuccessMessage"] = "No se pudo eliminar el contrato";
                Console.WriteLine(ex.Message);
            }
            return RedirectToAction(nameof(Index));
        }
    }
}