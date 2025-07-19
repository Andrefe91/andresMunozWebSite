import { Controller } from "@hotwired/stimulus";
import EmblaCarousel from "embla-carousel";
import Autoplay from "embla-carousel-autoplay";

// Connects to data-controller="carousel"
export default class extends Controller {
	static targets = ["viewport"];

	connect() {
		const options = {
			loop: true, // Whether to loop the carousel
			dragFree: false, // Whether to allow dragging
			dots: false, // Whether to show dots
			buttons: false, // Whether to show buttons
			axis: "x", // Axis of the carousel
			thumbnails: false, // Whether to show thumbnails
		};

		console.log(Autoplay);

		const autoplay = Autoplay({
			playOnInit: true,
			delay: 1000,
			stopOnInteraction: false,
			stopOnMouseEnter: false,
		});

		this.carousel = EmblaCarousel(this.viewportTarget, options, [autoplay]);

		console.log("Viewport target:", this.viewportTarget);
    console.log("EmblaCarousel:", this.carousel);

	}

	disconnect() {
		this.carousel?.destroy();
	}
}
