using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Proyecto_Inmobiliaria.Net_Core.Models
{
    public class Inquilino
    {
        [Key]
        [Display(Name = "Código")]
        public int Id { get; set; }
        [Required]
        public string Nombre { get; set; }
        [Required]
        public string Apellido { get; set; }
        [Required]
        public int Dni { get; set; }
        public string Telefono { get; set; }
        [Required, EmailAddress]
        public string Email { get; set; }
        [Required]
        public bool Estado { get; set; }
        
	}
}
