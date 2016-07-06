
##### ROC plot using grid

GeomROCplot <- ggproto(
   
   "GeomROCplot", Geom,
   required_aes = c("x", "y"),
   
   default_aes = aes(colour = "black",
                     size = 1,
                     linetype = 1,
                     alpha = 1,
                     fill = NA,
                     diagonal =TRUE,
                     diagonal_colour = 'black',
                     diagonal_alpha = 0.8,
                     diagonal_linetype = 2,
                     diagonal_width = 0.5 ),
   
   draw_key = draw_key_abline,
   
   draw_group = function(data, panel_scales, coord) {
      
      n <- nrow(data)
      if (n <= 2) return(grid::nullGrob())
      
      coords <- coord$transform(data, panel_scales)
      
      first_row <- coords[1, , drop = FALSE]
      
      if(first_row$diagonal){
         
         grid::gList(
            
            grid::linesGrob(
               x= coords$x,
               y=coords$y,
               default.units = "native",
               gp = grid::gpar(
                  
                  col = scales::alpha(
                     first_row$colour,
                     first_row$alpha),
                  
                  lwd = first_row$size * .pt,
                  lty = first_row$linetype)),
            
            grid::linesGrob(
               x=c(0,1),
               y=c(0,1),
               default.units = "native",
               gp = grid::gpar(
                  
                  col = scales::alpha(
                     first_row$diagonal_colour, 
                     first_row$diagonal_alpha),
                  
                  lwd = first_row$diagonal_width * .pt,
                  lty = first_row$diagonal_linetype
               )
            )
         )
      }
      
      else{
         grid::linesGrob(
            x= coords$x,
            y=coords$y,
            default.units = "native",
            gp = grid::gpar(
                      col = scales::alpha(
                               first_row$colour, 
                               first_row$alpha),
                            
                      lwd = first_row$size * .pt,
                      lty = first_row$linetype)
         )
      }
   }
)


geom_roc_plot <- function(
   
   mapping = NULL, 
   data = NULL,
   stat = "identity",
   position = "identity", 
   na.rm = FALSE, 
   show.legend = NA, 
   inherit.aes = TRUE, ...) {
   
   
   layer(
      geom = GeomROCplot, 
      mapping = mapping,
      data = data, 
      stat = stat,
      position = position, 
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = list(na.rm = na.rm, ...)
   )
   
}

