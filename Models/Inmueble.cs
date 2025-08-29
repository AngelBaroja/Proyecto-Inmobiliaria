using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace Proyecto_Inmobiliaria.Models
{
	[Table("Inmuebles")]
	public class Inmueble
	{
        [Key]
		[Display(Name = "Nº")]
		public int Id { get; set; }
		//[Required]
		[Display(Name = "Dirección")]
		[Required(ErrorMessage = "La dirección es requerida")]
		public string Direccion { get; set; }
		[Required]
		public int Ambientes { get; set; }
        [Required]
        public int Uso { get; set; }
        [Required]
        public string Tipo { get; set; }
        [Required]
		public int Superficie { get; set; }
        
		public decimal? Latitud { get; set; }
		public decimal? Longitud { get; set; }
		[Display(Name = "ID Dueño")]
		public int IdPropietario { get; set; }
		[ForeignKey(nameof(IdPropietario))]    
		public Propietario? Duenio { get; set; }	
		
		public string Estado { get; set; } 
	}
	
}
